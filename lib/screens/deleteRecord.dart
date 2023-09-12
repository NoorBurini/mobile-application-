import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteRecord extends StatefulWidget {
  static const String screenRoute = 'deleteRecord';
  const DeleteRecord({Key? key}) : super(key: key);

  @override
  _DeleteRecordState createState() => _DeleteRecordState();
}

class _DeleteRecordState extends State<DeleteRecord> {
  late String name = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _work_fieldController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final CollectionReference records =
      FirebaseFirestore.instance.collection("records");

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _addressController.text = documentSnapshot['address'];
      _work_fieldController.text = documentSnapshot['work_field'];
      _phoneController.text = documentSnapshot['phone'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'address'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'phone'),
                ),
                TextField(
                  controller: _work_fieldController,
                  decoration: const InputDecoration(labelText: 'work_field'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String address = _addressController.text;
                    final String phone = _phoneController.text;
                    final String workField = _work_fieldController.text;

                    await records.doc(documentSnapshot!.id).update({
                      "name": name,
                      "address": address,
                      "phone": phone,
                      "work_field": workField
                    });
                    _nameController.text = '';
                    _addressController.text = '';
                    _phoneController.text = '';
                    _work_fieldController.text = '';
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('You have successfully modified a record')));
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String recordId) async {
    await records.doc(recordId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a record')));
  }

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
            const SizedBox(height: 70),
            const Text(
              'Enter the name you want to delete or modify : ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 73, 3, 85),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter name',
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
                        .where("name", isEqualTo: name)
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
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
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
                                child: Row(children: [
                                  IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color.fromARGB(255, 73, 3, 85),
                                      ),
                                      onPressed: () => _update(document)),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Color.fromARGB(255, 73, 3, 85),
                                      ),
                                      onPressed: () => _delete(document.id)),
                                ]),
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
      ),
    );
  }
}
