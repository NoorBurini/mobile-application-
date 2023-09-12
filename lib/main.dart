import 'package:address/screens/addAdmin.dart';
import 'package:address/screens/addRecord.dart';
import 'package:address/screens/adminscreen.dart';
import 'package:address/screens/deleteRecord.dart';
import 'package:address/screens/searchByAddress.dart';
import 'package:address/screens/searchByName.dart';
import 'package:address/screens/searchByPhone.dart';
import 'package:address/screens/searchByWork.dart';
import 'package:flutter/material.dart';
import 'package:address/screens/registerU.dart';
import 'package:address/screens/signInU.dart';
import 'package:address/screens/signInA.dart';
import 'screens/welcome.dart';
import 'screens/welcome_user.dart';
import 'screens/welcome_admin.dart';
import 'package:address/screens/search.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Address Book app',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: WelcomeScreen.screenRoute,
        routes: {
          WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
          WelcomeScreenA.screenRoute: (context) => const WelcomeScreenA(),
          WelcomeScreenU.screenRoute: (context) => const WelcomeScreenU(),
          SignInScreenA.screenRoute: (context) => const SignInScreenA(),
          SignInScreenU.screenRoute: (context) => const SignInScreenU(),
          RegistrationScreenU.screenRoute: (context) =>
              const RegistrationScreenU(),
          SearchScreen.screenRoute: (context) => const SearchScreen(),
          searchName.screenRoute: (context) => const searchName(),
          searchAdd.screenRoute: (context) => const searchAdd(),
          searchWork.screenRoute: (context) => const searchWork(),
          searchPhone.screenRoute: (context) => const searchPhone(),
          AdminScreen.screenRoute: (context) => const AdminScreen(),
          AddRecord.screenRoute: (context) => const AddRecord(),
          DeleteRecord.screenRoute: (context) => const DeleteRecord(),
          AddAdmin.screenRoute: (context) => const AddAdmin(),
        }
        //home: searchName());
        );
  }
}
