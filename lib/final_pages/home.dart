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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          // appBar: AppBar(
          //   backgroundColor: Color.fromARGB(255, 0, 0, 0),
          //   centerTitle: true,
          //   title: const Text(
          //     'Home',
          //     style: TextStyle(
          //       color: Color.fromARGB(255, 255, 255, 255),
          //       // fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   leading: const IconButton(
          //     onPressed: null,
          //     icon: Icon(
          //       Icons.home,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 100, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    textAlign: TextAlign.center,
                    "Tinkerers' Lab",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(500, 50), primary: Colors.grey
                          // fixedSize: s
                          ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      child: Text(
                        style: TextStyle(fontSize: 15),
                        "Sign in with Google",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
