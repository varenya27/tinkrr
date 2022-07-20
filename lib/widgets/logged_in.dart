import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinkrr/provider/google_sign_in.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Tinkerers' Lab"),
            leading: Icon(Icons.home),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.face_sharp,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              )
            ],
          ),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(500, 50)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/request_items');
                          },
                          child: Text('Request from Inventory')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(500, 50)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/suggestions');
                          },
                          child: Text('Suggest a new item')),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("admin_emails")
                            .where('email', isEqualTo: user.email)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          // print(snapshot.data!.docs);
                          // print(user.email);
                          if (!snapshot.hasData) {
                            return Center(child: Text(' '));
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(child: Text(' '));
                          }
                          // if (false)
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(500, 50)),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/items');
                                    },
                                    child: Text('Inventory (Admin)')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(500, 50)),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/view_requests');
                                    },
                                    child: Text('View Requests (Admin)')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(500, 50)),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/view_suggestions');
                                    },
                                    child: Text('View Suggestions (Admin)')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(500, 50)),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/admins');
                                    },
                                    child: Text('Admins (Admin)')),
                              ),
                            ],
                          );
                        }),
                  ],
                )),
          )),
    );
  }
}
