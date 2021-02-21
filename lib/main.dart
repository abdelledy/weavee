import 'package:flutter/material.dart';
import 'package:weavee/screens/home.dart';
// import 'package:weavee/tests/two.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(99, 76, 255, 1),
      ),
      home: Home(),
    );
  }
}
