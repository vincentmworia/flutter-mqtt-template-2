import 'package:flutter/material.dart';

import './screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const _appTitle = 'MQTT TEST';
  static const _appPrimaryColor = Color(0xff002E63);//BLUE COOL BLACK
  static const _appSecondaryColor = Color(0xffb16002);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: _appPrimaryColor, secondary: _appSecondaryColor),
        appBarTheme: AppBarTheme(
          toolbarHeight: 70,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white, fontSize: 25.0, letterSpacing: 5.0),
        ).copyWith(iconTheme: const IconThemeData(size: 30.0),),
      ),
      home: const AuthScreen(),
    );
  }
}
