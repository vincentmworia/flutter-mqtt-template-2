import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

enum InternetStatus { online, offline, loading }

class _MyAppState extends State<MyApp> {
  var _internetStatus = InternetStatus.offline;
  final _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    print("CHANGED DEPENDENCIES");
    _connectivity.onConnectivityChanged.listen((event) {
      print(event);
      if (event == ConnectivityResult.none) {
        setState(() {
          print("offline");
          _internetStatus = InternetStatus.offline;
        });
      } else {
        print("online");
        setState(() {
          _internetStatus = InternetStatus.online;
        });
      }
    });
  }

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
          home: _internetStatus == InternetStatus.loading
              ? const Scaffold(
                  body: Center(
                    child: SpinKitRipple(
                        size: double.infinity, color: Colors.green),
                  ),
                )
              : _internetStatus == InternetStatus.online
                  ? const AuthScreen()
                  : const Scaffold(
                      body: Center(
                        child: Text("OFFLINE"),
                      ),
                    ),
          routes: {
            HomeScreen.routeName: (_) => const HomeScreen(),
            ScreenOne.routeName: (_) => const ScreenOne(),
            ScreenTwo.routeName: (_) => const ScreenTwo(),
            ScreenThree.routeName: (_) => const ScreenThree(),
          },
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (_) => const AuthScreen(),
          ),
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (_) => const AuthScreen(),
          ),
        ));
  }
}
