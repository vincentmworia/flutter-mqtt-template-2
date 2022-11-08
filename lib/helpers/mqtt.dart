import 'dart:async';
import 'dart:io';

import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

late MqttServerClient client;

Future<MqttServerClient> prepareMqttClient() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  print(deviceId);
  client = MqttServerClient.withPort(
      "ceb1d69ea6904c50836dc3ce8214c321.s1.eu.hivemq.cloud",
      'flutter_client/$deviceId',
      8883);
  client.secure = true;
  client.securityContext = SecurityContext.defaultContext;
  client.keepAlivePeriod = 20;
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;
  client.onSubscribed = onSubscribed;
  client.onUnsubscribed = onUnsubscribed;
  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;

  client.keepAlivePeriod = 60;
  // client.autoReconnect = true;
  /*SecurityContext context = SecurityContext()
    ..useCertificateChain('path/to/my_cert.pem')
    ..usePrivateKey('path/to/my_key.pem', password: 'key_password')
    ..setClientAuthorities('path/to/client.crt', password: 'password');*/

  final connMessage = MqttConnectMessage()
      .authenticateAs('Vincent', 'mycluster')
      .withWillTopic('will')
      .withWillMessage('Will message')
      .withWillRetain()
      .startClean()
      .withWillQos(MqttQos.exactlyOnce);
  client.connectionMessage = connMessage;

  client.secure = true;
  client.securityContext = SecurityContext.defaultContext;

  try {
    print("Connecting");
    await client.connect();
  } catch (e) {
    if (kDebugMode) {
      print('\n\nException: $e');
    }
    client.disconnect();
  }
  return client;
}

void publishMessage(String topic, String message) {
  final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
  builder.addString(message);
  if (kDebugMode) {
    print('Publishing message "$message" to topic $topic');
  }
  client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
}

void onConnected() {
  if (kDebugMode) {
    print('Connected');
  }
}

void onDisconnected() {
  if (kDebugMode) {
    print('Disconnected');
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
