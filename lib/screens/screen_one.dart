import 'package:flutter/material.dart';
import 'package:mqtt_template_2/helpers/mqtt.dart';
import 'package:provider/provider.dart';

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
        builder: (context, mqttProv, child) => Text(
        mqttProv.screenOneData,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      )),
    ));
  }
}
