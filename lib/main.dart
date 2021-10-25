import 'package:bmi/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/homepage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            )
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active){
                Object? user = snapshot.data;
                if(user == null){
                  return const Login();
                }else{
                  return const Homepage();
                }
              }
              return const Scaffold(
                  body: Center(
                    child: Text("Checking authentication..."),
                  )
              );

            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Scaffold(
            body: Center(
              child: Text("Connecting to the app..."),
            )
        );
      },
    );
  }
}

