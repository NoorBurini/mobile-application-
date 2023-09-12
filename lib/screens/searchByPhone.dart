import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class searchPhone extends StatefulWidget {
  static const String screenRoute = 'searchByPhone';

  const searchPhone({super.key});

  @override
  State<searchPhone> createState() => _searchPhoneState();
}

class _searchPhoneState extends State<searchPhone> {
  late String phone = "";

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

  Future sendEmail(var d) async {
    try {
      String data = d.toString();
      String userEmail = "addressbook2023@gmail.com";
      String password = "vxobpfobrnjswtho";

      final smtpServer = gmail(userEmail, password);

      final message = Message();
      message.subject = 'Your searching results ';
      message.from = Address(userEmail);
      message.recipients.add(signedInUser.email.toString());
      message.html = "<h3>$data </h3>\n<p>Thank you</p>";

      final SendReport =
          await send(message, smtpServer, timeout: const Duration(seconds: 5));
      print("Email has been sent successfuly. $SendReport");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email has been sent successfuly.')));
    } on MailerException catch (e) {
      print("error occurred ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 206, 171, 211),
      appBar: AppBar(title: const Text('Search By Phone')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Enter Phone',
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
          Expanded(
            child: Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("records")
                      .where("phone", isEqualTo: phone)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(data['name'] +
                                ", " +
                                data['work_field'] +
                                ", " +
                                data['phone'] +
                                ", " +
                                data['address']),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(
                                        Icons.email,
                                        color: Color.fromARGB(255, 73, 3, 85),
                                      ),
                                      onPressed: () {
                                        sendEmail(data);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
