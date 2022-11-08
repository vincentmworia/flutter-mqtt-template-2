import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mqtt.dart';


import '../widgets/custom_drawer.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  static const routeName = '/screen_one';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Screen One"),
      ),
      // drawer: const CustomDrawer(),
      body: Center(
        child: Consumer<MqttProvider>(
            builder: (BuildContext context, value, Widget? child) => Text(
                  value.screenOneData,
                  style: Theme.of(context).textTheme.bodyText1,
                )),
      ),
    ));
  }
}
