import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinkrr/provider/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Requests"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("requests")
                .where('approved', isEqualTo: false)
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
                            Text('Pending',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(
                                    'Nothing pending',
                                    textAlign: TextAlign.center,
                                  ),
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
                                'Pending',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
                                              document['roll']);
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: Text('Roll Number:'),
                                                trailing:
                                                    Text(document['roll']),
                                              ),
                                              ListTile(
                                                leading: Text('Device Name:'),
                                                trailing: Text(
                                                    document['device_name']),
                                              ),
                                              ListTile(
                                                leading: Text('Quantity:'),
                                                trailing: Text(
                                                    document['qty'].toString()),
                                              ),
                                              ListTile(
                                                leading: Text('Approved:'),
                                                trailing: Text(
                                                    document['approved']
                                                        .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("requests")
                .where('approved', isEqualTo: true)
                .orderBy(
                  "device_name",
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                // print('empty');
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: const <Widget>[
                            Text('Accepted',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                    title: Text(
                                  'Nothing borrowed',
                                  textAlign: TextAlign.center,
                                )),
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
                              Text(
                                'Accepted',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
                                        showCloseDialog(
                                            context,
                                            document.id,
                                            document['device_name'],
                                            document['qty'],
                                            document['roll']);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Text('Roll Number:'),
                                              trailing: Text(document['roll']),
                                            ),
                                            ListTile(
                                              leading: Text('Device Name:'),
                                              trailing:
                                                  Text(document['device_name']),
                                            ),
                                            ListTile(
                                              leading: Text('Quantity:'),
                                              trailing: Text(
                                                  document['qty'].toString()),
                                            ),
                                            ListTile(
                                              leading: Text('Approved:'),
                                              trailing: Text(
                                                  document['approved']
                                                      .toString()),
                                            ),
                                          ],
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
        ],
      ),
    );
  }
}

void showUpdateDialog(
    BuildContext context, String uid, String dev, int qty, String roll) {
  final myController1 = TextEditingController()..text = dev;
  final myController2 = TextEditingController()..text = 0.toString();
  final user = FirebaseAuth.instance.currentUser!;

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: Text('Update Request : ${roll.toUpperCase()}'),
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
                  enabled: false,
                  controller: myController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Quantity'),
                )
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Approve"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  DB_request(uid: uid).approveRequest(dev, qty, roll, true);
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  DB_request(uid: uid).deleteItems();
                  Navigator.pop(context);
                },
                child: const Text("Reject"),
              ),
            ],
          ));
}

void showCloseDialog(
    BuildContext context, String uid, String dev, int qty, String roll) {
  final myController1 = TextEditingController()..text = dev;
  final myController2 = TextEditingController()..text = 0.toString();
  final user = FirebaseAuth.instance.currentUser!;

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: Text('Close Request : ${roll.toUpperCase()}'),
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
                  enabled: false,
                  controller: myController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Quantity'),
                )
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  DB_request(uid: uid).deleteItems();
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              ),
            ],
          ));
}
