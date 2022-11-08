import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/screen_one.dart';
import './screens/screen_three.dart';
import './screens/screen_two.dart';
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
  // late MqttServerClient mqttClient;

  Future<void> _attemptMqttLogin() async => await prepareMqttClient();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MqttProvider(),
      child: MaterialApp(
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
            iconTheme: const IconThemeData(size: 30.0, color: Colors.white),
          ),
        ),
        home: AuthScreen(_attemptMqttLogin),
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          ScreenOne.routeName: (_) => const ScreenOne(),
          ScreenTwo.routeName: (_) => const ScreenTwo(),
          ScreenThree.routeName: (_) => const ScreenThree(),
        },
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (_) => AuthScreen(_attemptMqttLogin),
        ),
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => AuthScreen(_attemptMqttLogin),
        ),
      ),
    );
  }
}
