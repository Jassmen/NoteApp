import 'package:flutter/material.dart';
import 'package:jessynote/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JessyNote',
      debugShowCheckedModeBanner: false,
      home: new Home(),
    );
  }
}