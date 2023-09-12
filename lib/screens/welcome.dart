import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:address/screens/welcome_user.dart';
import 'package:address/screens/welcome_admin.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'Welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                  child: Image.asset('images/img.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Address Book',
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
              title: 'Admin',
              onPressed: () {
                Navigator.pushNamed(context, WelcomeScreenA.screenRoute);
              },
            ),
            MyButton(
              color: const Color.fromARGB(255, 122, 6, 143),
              title: 'User',
              onPressed: () {
                Navigator.pushNamed(context, WelcomeScreenU.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
