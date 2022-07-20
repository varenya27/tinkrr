import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinkrr/provider/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Admins extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admins"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("admin_emails")
            .orderBy(
              "email",
            )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // showDeleteDialog(
                    //   context,
                    //   document.id,
                    //   document['device_name'],
                    // );
                  },
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Expanded(child: Text(document['email'])),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAddDialog(context);
        },
      ),
    );
  }
}

void showAddDialog(BuildContext context) {
  final myController1 = TextEditingController();
  // final myController2 = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: Text('New Admin'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  // enabled: false,
                  textCapitalization: TextCapitalization.sentences,
                  controller: myController1,
                  decoration: InputDecoration(
                    labelText: 'Admin email',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  DB_admin().addAdmin(myController1.text);
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ));
}
