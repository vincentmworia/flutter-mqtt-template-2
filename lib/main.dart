import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connectivity_checker/internet_connectivity_checker.dart';
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
  var _internetStatus = InternetStatus.loading;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MqttProvider(),
        child: StreamBuilder(
          stream: InternetConnectivity().isConnectedToInternet(),
          builder: (context, snapshot) {
            if (snapshot.hasData && (snapshot.data as bool) == true) {
              _internetStatus = InternetStatus.online;
              // print("online");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              _internetStatus = InternetStatus.loading;
              // print("loading");
            } else {
              _internetStatus = InternetStatus.offline;
              // print("offline");
            }
            switch (_internetStatus) {
              case InternetStatus.online:
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
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                              color: Colors.white,
                              fontSize: 25.0,
                              letterSpacing: 5.0),
                    ).copyWith(
                      iconTheme:
                          const IconThemeData(size: 30.0, color: Colors.white),
                    ),
                  ),
                  home: const AuthScreen(),
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
                );
              case InternetStatus.offline:
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.white54,
                      body: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyApp._appPrimaryColor.withOpacity(0.95),
                              MyApp._appSecondaryColor.withOpacity(0.95),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "OFFLINE",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Colors.white, letterSpacing: 3.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              case InternetStatus.loading:
                return MaterialApp(debugShowCheckedModeBanner: false,
                  home: SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.white54,
                      body: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyApp._appPrimaryColor.withOpacity(0.95),
                              MyApp._appSecondaryColor.withOpacity(0.95),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const SpinKitRipple(
                            size: double.infinity, color: Colors.white),
                      ),
                    ),
                  ),
                );
            }
          },
        ));
  }
}
