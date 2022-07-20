import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tinkrr/pages/profile.dart';
import 'package:tinkrr/pages/suggestions.dart';
import 'package:tinkrr/pages/login.dart';
// import 'package:tinkrr/final_pages/home.dart';
import 'package:tinkrr/pages/home.dart';
import 'package:tinkrr/pages/view_requests.dart';
import 'package:tinkrr/pages/view_suggestions.dart';
import 'package:tinkrr/pages/admins.dart';
import 'package:tinkrr/pages/items.dart';
import 'package:tinkrr/pages/request_items.dart';
import 'package:tinkrr/provider/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: 'AIzaSyBSl1qHRQr0FNO1cnJuUlzu8Q0i1pV4tZc',
  //         appId: '1:639913670245:android:1207a7ce00287db5bf788c',
  //         messagingSenderId: '639913670245',
  //         projectId: 'tinkrr-2a9fb'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == "/login") {
            return PageRouteBuilder(
                settings:
                    settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => Login(),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c));
          }
          // Unknown route
          return MaterialPageRoute(builder: (_) => Login());
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: '/login',
        routes: {
          // '/': (context) => Loading(),
          '/login': (context) => Login(),
          '/items': (context) => ItemList(),
          '/home': (context) => Home(),
          '/suggestions': (context) => Suggestions(),
          '/view_suggestions': (context) => ViewSuggestions(),
          '/profile': (context) => Profile(),
          '/request_items': (context) => ItemListRequests(),
          '/admins': (context) => Admins(),
          '/view_requests': (context) => ViewRequests(),
        },
      ),
    );
  }
}
