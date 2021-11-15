import 'package:flutter/material.dart';

import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      "/": (context) => HomePage(),
      "/homePage1": (context) => HomePage(),
      // "/txtFieldPage":(context)=>TxtFieldSugges(),
    });
  }
}
