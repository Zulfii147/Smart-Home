import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;


  @override

  void initState() {

    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 1),
    vsync: this,upperBound: 100.0
    );
    controller.forward();
    controller.addListener(() { 
      setState(() {});
      print(controller.value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: controller.value,
                    child: Center(child: Image.asset('images/smarthouse-remove.png')),
                  ),
                ),
         SizedBox(
      width: 200.0,
      child: DefaultTextStyle(
        style: const TextStyle(
        fontSize: 35.0,
        color: Colors.white,
        fontFamily: 'Bobbers',
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText('Smart Home',),

        ],
      ),
    ),
    ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}