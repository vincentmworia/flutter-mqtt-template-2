import 'package:flutter/material.dart';
import 'package:mqtt_template_2/helpers/mqtt.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen(/*this.attemptMqttLogin,*/ {Key? key}) : super(key: key);

  static const routeName = '/auth_screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  OutlineInputBorder _outlinedInputBorder(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        gapPadding: 4.0,
        borderSide: BorderSide(
          color: color,
          width: 2.0,
        ),
      );

  Widget _textFormField(
          {required String hintText,
          required String labelText,
          required IconData icon}) =>
      TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

          prefixIcon: Icon(icon),
          hintText: hintText,
          // labelText: labelText,

          // TODO PRESSED
          focusedBorder:
              _outlinedInputBorder(Theme.of(context).colorScheme.primary),
          // TODO UNPRESSED
          enabledBorder: _outlinedInputBorder(Colors.grey),
        ),
      );
  var _isLoggingIn = false;

  Future<void> _attemptLogin() async {
    setState(() {
      _isLoggingIn = true;
    });
    final connectionStatus =
        await Provider.of<MqttProvider>(context, listen: false)
            .initializeMqttClient();
    switch (connectionStatus) {
      case ConnectionStatus.disconnected:
        Future.delayed(Duration.zero).then((value) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Disconnected")));
        });
        break;
      case ConnectionStatus.connected:
        Future.delayed(Duration.zero).then((value) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Connected"),
            duration: Duration(seconds: 2),
          ));
        }).then((value) =>
            Navigator.pushReplacementNamed(context, HomeScreen.routeName));
        break;
    }

    Future.delayed(Duration.zero).then((value) =>
        Navigator.pushReplacementNamed(context, HomeScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;
    const opValue = 0.75;
    final background = Container(
      width: double.infinity,
      height: deviceHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(opValue),
            Theme.of(context).colorScheme.secondary.withOpacity(opValue),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
    return SafeArea(
        child: Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(opValue * 0.5),
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            background,
            SizedBox(
              height: deviceHeight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: LayoutBuilder(builder: (context, cons) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: cons.maxHeight * 0.25,
                  width: cons.maxHeight * 0.25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Image.asset('images/logo.PNG'),
                        ),
                        SizedBox(
                          height: cons.maxHeight * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _textFormField(
                                  hintText: "Username",
                                  labelText: "Enter your name",
                                  icon: Icons.person),
                              const SizedBox(height: 30),
                              _textFormField(
                                  hintText: "Password",
                                  labelText: "Enter your password",
                                  icon: Icons.lock),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: cons.maxHeight * 0.15,
                          child: Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(200, 75),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: _isLoggingIn ? null : _attemptLogin,
                                child: Text(
                                  "Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.white,
                                        letterSpacing: 5.0,
                                        fontSize: 20,
                                      ),
                                )),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
