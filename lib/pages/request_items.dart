// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinkrr/provider/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemListRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request from Inventory"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where('type', isEqualTo: 'Measurement')
                .orderBy(
                  "device_name",
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: const <Widget>[
                            Text('Measurement Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text('No Items'),
                                ),
                              ),
                            ),
                          ]),
                        ))));
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
                              const Text(
                                'Measurement Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Card(
                                  color: Color.fromARGB(255, 236, 236, 236),
                                  child: ListTile(
                                    leading: Text('Device'),
                                    trailing: Text('Qty'),
                                  ),
                                ),
                              ),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showUpdateDialog(
                                            context,
                                            document.id,
                                            document['device_name'],
                                            document['qty'],
                                            document['type']);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading:
                                              Text(document['device_name']),
                                          trailing: Text(
                                            document['qty'].toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where('type', isEqualTo: 'Electronic')
                .orderBy(
                  "device_name",
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: const <Widget>[
                            Text('Electronic Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text('No Items'),
                                ),
                              ),
                            ),
                          ]),
                        ))));
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
                              const Text(
                                'Electronic Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Card(
                                  color: Color.fromARGB(255, 236, 236, 236),
                                  child: ListTile(
                                    leading: Text('Device'),
                                    trailing: Text('Qty'),
                                  ),
                                ),
                              ),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showUpdateDialog(
                                            context,
                                            document.id,
                                            document['device_name'],
                                            document['qty'],
                                            document['type']);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading:
                                              Text(document['device_name']),
                                          trailing: Text(
                                            document['qty'].toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where('type', isEqualTo: 'Mechanical')
                .orderBy(
                  "device_name",
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: const <Widget>[
                            Text('Mechanical Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text('No Items'),
                                ),
                              ),
                            ),
                          ]),
                        ))));
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
                              const Text(
                                'Mechanical Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Card(
                                  color: Color.fromARGB(255, 236, 236, 236),
                                  child: ListTile(
                                    leading: Text('Device'),
                                    trailing: Text('Qty'),
                                  ),
                                ),
                              ),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showUpdateDialog(
                                            context,
                                            document.id,
                                            document['device_name'],
                                            document['qty'],
                                            document['type']);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading:
                                              Text(document['device_name']),
                                          trailing: Text(
                                            document['qty'].toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where('type', isEqualTo: 'Boards')
                .orderBy(
                  "device_name",
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: const <Widget>[
                            Text('Boards Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text('No Items'),
                                ),
                              ),
                            ),
                          ]),
                        ))));
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
                              const Text(
                                'Boards Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Card(
                                  color: Color.fromARGB(255, 236, 236, 236),
                                  child: ListTile(
                                    leading: Text('Device'),
                                    trailing: Text('Qty'),
                                  ),
                                ),
                              ),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showUpdateDialog(
                                            context,
                                            document.id,
                                            document['device_name'],
                                            document['qty'],
                                            document['type']);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading:
                                              Text(document['device_name']),
                                          trailing: Text(
                                            document['qty'].toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where('type', isEqualTo: 'Accessories')
                .orderBy(
                  "device_name",
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: const <Widget>[
                            Text('Accessories Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text('No Items'),
                                ),
                              ),
                            ),
                          ]),
                        ))));
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
                              const Text(
                                'Accessories Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Card(
                                  color: Color.fromARGB(255, 236, 236, 236),
                                  child: ListTile(
                                    leading: Text('Device'),
                                    trailing: Text('Qty'),
                                  ),
                                ),
                              ),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showUpdateDialog(
                                            context,
                                            document.id,
                                            document['device_name'],
                                            document['qty'],
                                            document['type']);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading:
                                              Text(document['device_name']),
                                          trailing: Text(
                                            document['qty'].toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
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
          SizedBox(
            height: 90,
          )
        ],
      ),
    );
  }
}

void showUpdateDialog(
    BuildContext context, String uid, String dev, int qty, String type) {
  final user = FirebaseAuth.instance.currentUser!;
  // String type = 'Measurement';
  final myController1 = TextEditingController()..text = dev;
  final myController2 = TextEditingController()..text = 0.toString();
  final itemList = [
    'Measurement',
    'Electronic',
    'Mechanical',
    'Boards',
    'Accessories'
  ];
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Request Item'),
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
                  TextField(
                    controller: myController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantity'),
                  ),
                  DropdownButton(
                      value: type,
                      items: itemList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (_) {})
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("Request"),
                  onPressed: () {
                    String roll = user.email!;
                    roll = roll.split('@')[0];
                    DB_request(uid: uid).addRequest(myController1.text,
                        int.parse(myController2.text), roll, false);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }));
}
