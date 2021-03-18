import 'package:bus_route/screens/LoginPage.dart';
import 'package:bus_route/screens/MainPage.dart';
import 'package:bus_route/screens/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:607117099432:ios:b5cdae04248222f3d15d9d',
            apiKey: 'AIzaSyDvhPQE5YhkmtH2pVApulsGzo0NqVj-3B8',
            projectId: 'busroute-d7092',
            messagingSenderId: '607117099432',
            databaseURL: 'https://busroute-d7092-default-rtdb.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:607117099432:android:d0b458d5ccc133b0d15d9d',
            apiKey: 'AIzaSyAgVCkwQyeHZfPSJRaguMgIHhMmAPIuFbQ',
            messagingSenderId: '297855924061',
            projectId: 'busroute-d7092',
            databaseURL: 'https://busroute-d7092-default-rtdb.firebaseio.com',
          ),
  );

  runApp(BusRoute());
}

class BusRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Roboto', primaryColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegistrationPage.id: (context) => RegistrationPage(),
          MainPage.id: (context) => MainPage(),
        });
  }
}
