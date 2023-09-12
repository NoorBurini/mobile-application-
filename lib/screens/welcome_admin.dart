import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:address/screens/signInA.dart';

class WelcomeScreenA extends StatefulWidget {
  static const String screenRoute = 'welcome_admin';
  const WelcomeScreenA({Key? key}) : super(key: key);

  @override
  _WelcomeScreenAState createState() => _WelcomeScreenAState();
}

class _WelcomeScreenAState extends State<WelcomeScreenA> {
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
                  child: Image.asset('images/admin.png'),
                ),
                const Text(
                  'Welcome Admin',
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
              color: Color.fromARGB(255, 73, 3, 85),
              title: 'Sign In',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreenA.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
