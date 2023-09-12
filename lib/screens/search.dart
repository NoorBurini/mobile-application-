import 'package:address/screens/searchByName.dart';
import 'package:address/screens/searchByAddress.dart';
import 'package:address/screens/searchByWork.dart';
import 'package:address/screens/searchByPhone.dart';
import 'package:address/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:address/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchScreen extends StatefulWidget {
  static const String screenRoute = 'search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  @override
  void initState() {
    // TODO: implement initState
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
            title: const Text('Searching Category'),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Please select your searching category :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 73, 3, 85),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.person,
                      color: Color.fromARGB(255, 122, 6, 143), size: 50),
                  const SizedBox(width: 10),
                  MyButton(
                    color: const Color.fromARGB(255, 122, 6, 143),
                    title: 'Name',
                    onPressed: () {
                      Navigator.pushNamed(context, searchName.screenRoute);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.perm_contact_calendar_outlined,
                    color: Color.fromARGB(255, 122, 6, 143),
                    size: 50,
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    color: const Color.fromARGB(255, 122, 6, 143),
                    title: 'Address',
                    onPressed: () {
                      Navigator.pushNamed(context, searchAdd.screenRoute);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.phone,
                      color: Color.fromARGB(255, 122, 6, 143), size: 50),
                  const SizedBox(width: 10),
                  MyButton(
                    color: const Color.fromARGB(255, 122, 6, 143),
                    title: 'Phone number',
                    onPressed: () {
                      Navigator.pushNamed(context, searchPhone.screenRoute);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.work,
                    color: Color.fromARGB(255, 122, 6, 143),
                    size: 50,
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    color: const Color.fromARGB(255, 122, 6, 143),
                    title: 'Work field',
                    onPressed: () {
                      Navigator.pushNamed(context, searchWork.screenRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
