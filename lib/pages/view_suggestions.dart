import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinkrr/pages/suggestions.dart';
import 'package:tinkrr/provider/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Suggestions"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("suggestions")
                .orderBy(
                  "device_name",
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // ignore: prefer_const_constructors
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: SizedBox(
                                  child: const Card(
                                    color: Color.fromARGB(255, 236, 236, 236),
                                    child: ListTile(
                                      leading: Text('Device Name'),
                                      trailing: Text('Roll Number'),
                                    ),
                                  ),
                                ),
                              ),

                              // const Text(
                              //   'Current Suggestions',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold, fontSize: 20),
                              // ),
                              ListView(
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  return Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
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
                                                leading: Text(
                                                    document['device_name']),
                                                trailing: Text(
                                                    (document['roll'])
                                                        .toString()
                                                        .toUpperCase()),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      )),
                );
              }
            },
          ),
        ],
      ),
    );
  }
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
