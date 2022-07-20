// ignore_for_file: prefer_const_constructors
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tinkrr/provider/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              // fontWeight: FontWeight.bold,
            ),
          ),
          leading: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogout();
                    },
                    child: Text('Log out')),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text("Log in"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    }),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text("Items"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/items');
                    }),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text("Request Items"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/request_items');
                    }),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text("User Details"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/details');
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
