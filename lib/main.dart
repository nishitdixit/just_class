import 'package:flutter/material.dart';
import 'package:just_class/calling_constructor.dart';
import 'package:just_class/tiles.dart';

void main() {
  runApp(MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tiles(),
    );
  }
}
