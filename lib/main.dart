import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import './helpers/mqtt.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'MQTT TEST';
  static const _appPrimaryColor = Color(0xff002E63); //BLUE COOL BLACK
  static const _appSecondaryColor = Color(0xffb16002);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MqttServerClient mqttClient;

  Future<void> _attemptMqttLogin() async =>
      mqttClient = await prepareMqttClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: MyApp._appPrimaryColor,
            secondary: MyApp._appSecondaryColor),
        appBarTheme: AppBarTheme(
          toolbarHeight: 70,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white, fontSize: 25.0, letterSpacing: 5.0),
        ).copyWith(
          iconTheme: const IconThemeData(size: 30.0),
        ),
      ),
      home: AuthScreen(_attemptMqttLogin),
    );
  }
}
