import 'package:buy_it_app/screens/base/base.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buy It',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const BaseApp(),
    );
  }
}
