import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinkrr/provider/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tinkrr/provider/google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogout();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        user.displayName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.email!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("requests")
                    .where('roll', isEqualTo: user.email!.split('@')[0])
                    .where('approved', isEqualTo: true)
                    .orderBy(
                      "device_name",
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                Text('Borrowed Items',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text('No Items Borrowed'),
                                    ),
                                  ),
                                ),
                              ]),
                            ))));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Borrowed Items',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
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
                    .collection("requests")
                    .where('roll', isEqualTo: user.email!.split('@')[0])
                    .where('approved', isEqualTo: false)
                    .orderBy(
                      "device_name",
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    print('empty');
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: const <Widget>[
                                Text('Requested Items',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  child: Card(
                                    color: Colors.white,
                                    child: Text('No Items Requested'),
                                  ),
                                ),
                              ]),
                            ))));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Requested Items',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 10),
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
                                                document['qty']);
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
            ],
          ),
        ));
  }
}

void showUpdateDialog(BuildContext context, String uid, String dev, int qty) {
  final myController1 = TextEditingController()..text = dev;
  final myController2 = TextEditingController()..text = qty.toString();

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: const Text('Delete Request'),
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
                child: const Text("Delete"),
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  DB_request(uid: uid).deleteItems();
                  Navigator.pop(context);
                },
              ),
            ],
          ));
}
