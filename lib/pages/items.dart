import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinkrr/provider/database.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
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
  final myController2 = TextEditingController();
  final itemList = [
    'Measurement',
    'Electronic',
    'Mechanical',
    'Boards',
    'Accessories'
  ];
  String type = 'Measurement';
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: myController1,
                    decoration: InputDecoration(labelText: 'Device Name'),
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
                      onChanged: (String? newType) {
                        setState(() => type = newType!);
                      })
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("Add"),
                  onPressed: () {
                    DB().addItems(myController1.text,
                        int.parse(myController2.text), type);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }));
}

void showUpdateDialog(
    BuildContext context, String uid, String dev, int qty, String type) {
  // String type = 'Measurement';
  final myController1 = TextEditingController()..text = dev;
  final myController2 = TextEditingController()..text = qty.toString();
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
              title: const Text('Update Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
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
                      onChanged: (String? newType) {
                        setState(() => type = newType!);
                      })
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("Update"),
                  onPressed: () {
                    DB(uid: uid).updateItems(myController1.text,
                        int.parse(myController2.text), type);
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text("Delete"),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    DB(uid: uid).deleteItems();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }));
}
