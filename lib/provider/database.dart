import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final String? uid;
  DB({this.uid});
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  Future updateItems(String device, int qty, String type) async {
    return await itemCollection
        .doc(uid)
        .set({'device_name': device, 'qty': qty, 'type': type});
  }

  Future addItems(String device, int qty, String type) async {
    return await itemCollection.add({'device_name': device, 'qty': qty, 'type': type});
  }

  Future deleteItems() async {
    return await itemCollection.doc(uid).delete();
  }
}

class DB_request {
  final String? uid;
  DB_request({this.uid});
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('requests');

  Future approveRequest(String device, int qty, String roll, bool check) async {
    return await itemCollection.doc(uid).set(
        {'device_name': device, 'qty': qty, 'roll': roll, 'approved': check});
  }

  Future addRequest(String device, int qty, String roll, bool check) async {
    return await itemCollection.add(
        {'device_name': device, 'qty': qty, 'roll': roll, 'approved': check});
  }

  Future deleteItems() async {
    return await itemCollection.doc(uid).delete();
  }
}

class DB_suggest {
  final String? uid;
  DB_suggest({this.uid});
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('suggestions');

  Future addSuggestion(String device, String roll) async {
    return await itemCollection.add({'device_name': device, 'roll': roll, });
  }

  Future deleteSuggestion() async {
    return await itemCollection.doc(uid).delete();
  }
}

class DB_admin {
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('admin_emails');

  Future addAdmin(String email) async {
    return await itemCollection.add({'email': email});
  }
}
