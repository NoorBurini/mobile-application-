import 'package:address/screens/addAdmin.dart';
import 'package:address/screens/welcome.dart';
import 'package:address/screens/addRecord.dart';
import 'package:address/screens/deleteRecord.dart';
import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminScreen extends StatefulWidget {
  static const String screenRoute = 'adminScreen';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 206, 171, 211),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 122, 6, 143),
            title: const Text('Editing options'),
            actions: [
              IconButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, WelcomeScreen.screenRoute);
                  },
                  icon: const Icon(Icons.close))
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 160,
                child: Image.asset('images/admin.png'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyButton(
                    color: const Color.fromARGB(255, 122, 6, 143),
                    title: 'Add record',
                    onPressed: () {
                      Navigator.pushNamed(context, AddRecord.screenRoute);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyButton(
                    color: const Color.fromARGB(255, 122, 6, 143),
                    title: 'Delete And Modify record',
                    onPressed: () {
                      Navigator.pushNamed(context, DeleteRecord.screenRoute);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyButton(
                    color: const Color.fromARGB(255, 122, 6, 143),
                    title: 'Add Admin',
                    onPressed: () {
                      Navigator.pushNamed(context, AddAdmin.screenRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
