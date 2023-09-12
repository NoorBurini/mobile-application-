import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:address/screens/registerU.dart';
import 'package:address/screens/signInU.dart';

class WelcomeScreenU extends StatefulWidget {
  static const String screenRoute = 'welcome_user';
  const WelcomeScreenU({Key? key}) : super(key: key);

  @override
  _WelcomeScreenUState createState() => _WelcomeScreenUState();
}

class _WelcomeScreenUState extends State<WelcomeScreenU> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 206, 171, 211),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Image.asset('images/user.png'),
                ),
                const Text(
                  'Welcome User',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 73, 3, 85),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            MyButton(
              color: const Color.fromARGB(255, 122, 6, 143),
              title: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreenU.screenRoute);
              },
            ),
            MyButton(
              color: const Color.fromARGB(255, 122, 6, 143),
              title: 'Sign In',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreenU.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
