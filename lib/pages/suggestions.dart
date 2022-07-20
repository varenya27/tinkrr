import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinkrr/provider/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

String dev = '', roll = '';

class Suggestions extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Suggestions"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("suggestions")
            .orderBy(
              "device_name",
            )
            .where('roll', isEqualTo: user!.email!.split('@')[0])
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: Text('No Suggestions'));

          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              dev = document['device_name'];
              roll = document['roll'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showDeleteDialog(
                      context,
                      document.id,
                      document['device_name'],
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Expanded(child: Text(document['device_name'])),
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
          showSuggestDialog(context, roll);
        },
      ),
    );
  }
}

void showSuggestDialog(BuildContext context, String roll) {
  final myController1 = TextEditingController();
  // final myController2 = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: Text('New Suggestion'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  // enabled: false,
                  textCapitalization: TextCapitalization.sentences,
                  controller: myController1,
                  decoration: InputDecoration(
                    labelText: 'Device Name',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  DB_suggest().addSuggestion(myController1.text, roll);
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ));
}

void showDeleteDialog(BuildContext context, String uid, String dev) {
  final myController1 = TextEditingController()..text = dev;
  final myController2 = TextEditingController()..text = 0.toString();
  final user = FirebaseAuth.instance.currentUser!;

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: Text('Suggestion'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  enabled: false,
                  textCapitalization: TextCapitalization.sentences,
                  controller: myController1,
                  decoration: InputDecoration(
                    labelText: 'Device Name',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  DB_suggest(uid: uid).deleteSuggestion();
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
              ),
            ],
          ));
}
