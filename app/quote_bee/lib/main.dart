import 'package:flutter/material.dart';
import 'constants.dart';
import './pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote Bee',
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
      ),
      home: HomePage(),
    );
  }
}
