// cgfbkdf
import 'package:clone_simple_twite_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Clone App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Twitter Clone App'),
        ),
        body: HomePage(),
      ),
    );
  }
}
