import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'IOT TEMPLATE';
  static const _appPrimaryColor = Color(0xff4169e1);
  static const _appSecondaryColor = Color(0xfa3EB489);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
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
        ).copyWith(iconTheme: const IconThemeData(size: 30.0)),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("TITLE"),
          ),
          body: Center(
            child: Text(
              "WELCOME",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
      ),
    );
  }
}
