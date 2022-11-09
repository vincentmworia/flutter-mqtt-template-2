import 'package:flutter/material.dart';
import 'package:mqtt_template_2/helpers/mqtt.dart';
import 'package:provider/provider.dart';

import '../screens/auth_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Widget _buildDrawer({
    required Widget icon,
    required String title,
    required void Function() onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: icon,
          title: Text(
            title,
            style: const TextStyle(fontSize: 20.0),
          ),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: _buildDrawer(
                icon: const Icon(Icons.logout),
                title: "Logout",
                onTap: () {
                  print("Logout");
                  // client.unsubscribe('cbes/heatingunit/#');
                  Provider.of<MqttProvider>(context, listen: false)
                      .mqttClient
                      .disconnect();
                  Navigator.pushReplacementNamed(context, AuthScreen.routeName);
                }),
          )
        ],
      ),
    );
  }
}
