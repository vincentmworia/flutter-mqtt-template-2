import 'package:flutter/material.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({Key? key}) : super(key: key);
  static const routeName = '/screen_three';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Screen Three"),
      ),
      // drawer: const CustomDrawer(),
      body: Center(
        child: Text(
          "Screen Three",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ));
  }
}
