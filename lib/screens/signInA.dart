import 'package:address/screens/adminscreen.dart';
import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignInScreenA extends StatefulWidget {
  static const String screenRoute = 'SignInA';
  const SignInScreenA({Key? key}) : super(key: key);

  @override
  _SignInScreenAState createState() => _SignInScreenAState();
}

class _SignInScreenAState extends State<SignInScreenA> {
  final _auth = FirebaseAuth.instance;
  late String username;
  late String password;
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
            SizedBox(
              height: 200,
              child: Image.asset('images/admin.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                username = value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your username',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 73, 3, 85),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 73, 3, 85),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 73, 3, 85),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 73, 3, 85),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            MyButton(
              color: const Color.fromARGB(255, 73, 3, 85),
              title: 'sign in',
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: username, password: password);
                  Navigator.pushNamed(context, AdminScreen.screenRoute);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "User not found",
                      buttons: [
                        DialogButton(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Try again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                  } else if (e.code == 'invalid-email') {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "The email address is not accepted",
                      buttons: [
                        DialogButton(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Try again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                  } else if (e.code == 'wrong-password') {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "The password is invalid",
                      buttons: [
                        DialogButton(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Try again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                  } else {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: e.code,
                      buttons: [
                        DialogButton(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Try again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
