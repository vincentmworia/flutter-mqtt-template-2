import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum ConnectionStatus {
  disconnected,
  connected,
}

// todo subscribe to all mqtt channels
class MqttProvider with ChangeNotifier {
  // MqttServerClient? _mqttClient;
  late MqttServerClient _mqttClient;

  MqttServerClient get mqttClient => _mqttClient;

  String get screenOneData => _screenOneData;

  String get screenTwoData => _screenTwoData;

  String get screenThreeData => _screenThreeData;
  var _screenOneData = "SCREEN ONE";
  var _screenTwoData = "SCREEN TWO";
  var _screenThreeData = "SCREEN THREE";

  Future<ConnectionStatus> initializeMqttClient() async {
    var connectionStatus = ConnectionStatus.disconnected;
    // todo Get device unique id
    // String? deviceId = await PlatformDeviceId.getDeviceId;
    String? deviceId = "Phone";

    // print(deviceId);

    _mqttClient = MqttServerClient.withPort(
        "ceb1d69ea6904c50836dc3ce8214c321.s1.eu.hivemq.cloud",
        'flutter_client/$deviceId',
        8883);
    _mqttClient.secure = true;
    _mqttClient.securityContext = SecurityContext.defaultContext;
    _mqttClient.keepAlivePeriod = 20;
    _mqttClient.onConnected = onConnected;
    _mqttClient.onDisconnected = onDisconnected;
    _mqttClient.onSubscribed = onSubscribed;
    _mqttClient.onUnsubscribed = onUnsubscribed;
    _mqttClient.onSubscribed = onSubscribed;
    _mqttClient.onSubscribeFail = onSubscribeFail;
    _mqttClient.pongCallback = pong;

    _mqttClient.keepAlivePeriod = 60;
    // client.autoReconnect = true;
    /*SecurityContext context = SecurityContext()
    ..useCertificateChain('path/to/my_cert.pem')
    ..usePrivateKey('path/to/my_key.pem', password: 'key_password')
    ..setClientAuthorities('path/to/client.crt', password: 'password');*/

    final connMessage = MqttConnectMessage()
        .authenticateAs('Vincent', 'mycluster')
        .withWillTopic('will/phone/$deviceId')
        .withWillMessage('$deviceId disconnected')
        // .withWillRetain()
        .startClean()
        .withWillQos(MqttQos.exactlyOnce);
    _mqttClient.connectionMessage = connMessage;

    _mqttClient.secure = true;
    _mqttClient.securityContext = SecurityContext.defaultContext;

    try {
      if (kDebugMode) {
        print("Connecting");
      }
     final ok= await _mqttClient.connect();
      connectionStatus = ConnectionStatus.connected;
    } catch (e) {
      if (kDebugMode) {
        print('\n\nException: $e');
      }
      _mqttClient.disconnect();
      connectionStatus = ConnectionStatus.disconnected;
    }
    if (connectionStatus == ConnectionStatus.connected) {
      _mqttClient.subscribe("cbes/dekut/#", MqttQos.exactlyOnce);

      _mqttClient.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final topic = c[0].topic;
        print(topic);
        final message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        final topicBreakdown = topic.split('/');
        if (topicBreakdown[3] == "tank1") {
          _screenOneData = message;
        }
        if (topicBreakdown[3] == "tank2") {
          _screenTwoData = message;
        }
        if (topicBreakdown[3] == "tank3") {
          _screenThreeData = message;
        }
        notifyListeners();
      });
    }

    return connectionStatus;
  }

  void publishMessage(String topic, String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    if (kDebugMode) {
      print('Publishing message "$message" to topic $topic');
    }
    _mqttClient.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void onConnected() {
    if (kDebugMode) {
      print('Connected');
    }
  }

  void onDisconnected() {
    if (kDebugMode) {
      print('Disconnected');
      // TODO ON DISCONNECTED, FORCE THE USER OFFLINE
    }
  }

  void onSubscribed(String topic) {
    if (kDebugMode) {
      print('Subscribed topic: $topic');
    }
  }

  void onSubscribeFail(String topic) {
    if (kDebugMode) {
      print('Failed to subscribe $topic');
    }
  }

  void onUnsubscribed(String? topic) {
    if (kDebugMode) {
      print('Unsubscribed topic: $topic');
    }
  }

  void pong() {
    if (kDebugMode) {
      print('Ping response client callback invoked');
    }
  }
}
