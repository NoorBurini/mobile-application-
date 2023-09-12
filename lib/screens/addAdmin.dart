import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddAdmin extends StatefulWidget {
  static const String screenRoute = 'addAdmin';
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
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
            const Text('Add Admin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 73, 3, 85),
                )),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Admin Email',
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
                hintText: 'Enter password',
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
              title: 'Add',
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  Alert(
                    context: context,
                    title: "Done",
                    desc: "Admin is added successfuly",
                    buttons: [
                      DialogButton(
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                        child: const Text(
                          "OK",
                          style: TextStyle(
                              color: Color.fromARGB(255, 73, 3, 85),
                              fontSize: 20),
                        ),
                      )
                    ],
                  ).show();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "This email is already in use",
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
                  } else if (e.code == 'weak-password') {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "Password must be at least 6 characters",
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
