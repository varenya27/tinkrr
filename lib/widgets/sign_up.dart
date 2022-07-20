import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tinkrr/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                    final provider = Provider.of<GoogleSignInProvider>(context,
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
    ));
  }
}
