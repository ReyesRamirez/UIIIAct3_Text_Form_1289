import 'package:flutter/material.dart';
import 'package:myapp/form.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3.2 Flutter Push Pop',
      theme: ThemeData.light(),
      home: const MyForm(),
    );
  }
}