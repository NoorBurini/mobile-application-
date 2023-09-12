import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:address/screens/search.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignInScreenU extends StatefulWidget {
  static const String screenRoute = 'SignInU';
  const SignInScreenU({Key? key}) : super(key: key);

  @override
  _SignInScreenUState createState() => _SignInScreenUState();
}

class _SignInScreenUState extends State<SignInScreenU> {
  final _auth = FirebaseAuth.instance;
  late String email;
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
              height: 180,
              child: Image.asset('images/user.png'),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your Email',
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
                      email: email, password: password);
                  Navigator.pushNamed(context, SearchScreen.screenRoute);
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
