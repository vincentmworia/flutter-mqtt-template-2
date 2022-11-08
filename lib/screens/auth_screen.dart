import 'package:flutter/material.dart';
import '../../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen(this.attemptMqttLogin, {Key? key}) : super(key: key);
  final Function attemptMqttLogin;

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
          width: 1.0,
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
          Theme.of(context).colorScheme.primary.withOpacity(opValue),
      body: Stack(
        alignment: Alignment.center,
        children: [
          background,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: LayoutBuilder(builder: (context, cons) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: cons.maxHeight * 0.2,
                      child: Center(
                        child: Text(
                          MyApp.appTitle,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    letterSpacing: 5.0,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: cons.maxHeight * 0.5,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
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
                                const SizedBox(height: 30),
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 75),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async{
                                await  widget.attemptMqttLogin();
                                  print("Attepmting Login");
                                },
                                child: const Text("Login"))
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    ));
  }
}
