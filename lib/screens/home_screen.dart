import 'package:flutter/material.dart';
import 'package:mqtt_template_2/screens/screen_one.dart';
import 'package:mqtt_template_2/screens/screen_three.dart';
import 'package:mqtt_template_2/screens/screen_two.dart';

import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home_screen';

  Widget _button(context, title, routeName) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              fixedSize: const Size(200, 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Text(title),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("HOME PAGE"),
      ),
      drawer: const CustomDrawer(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _button(context, "ScreenOne", ScreenOne.routeName),
            _button(context, "ScreenTwo", ScreenTwo.routeName),
            _button(context, "ScreenThree", ScreenThree.routeName),
          ],
        ),
      ),
    ));
  }
}
