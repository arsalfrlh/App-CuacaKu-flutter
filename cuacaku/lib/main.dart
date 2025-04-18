import 'package:cuacaku/pages/cuaca_page.dart';
import 'package:cuacaku/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CuacaKu',
      home: HomePage(),
    );
  }
}