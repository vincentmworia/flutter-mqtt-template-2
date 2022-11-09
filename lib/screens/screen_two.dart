import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mqtt.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({Key? key}) : super(key: key);
  static const routeName = '/screen_two';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Screen Two"),),
          // drawer: const CustomDrawer(),
          body: Center(
              child: Consumer<MqttProvider>(
                builder: (context, mqttProv, child) => Text(
                  mqttProv.screenTwoData,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
        ));
  }
}
