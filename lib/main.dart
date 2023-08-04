import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/start.dart';

void main() {
  runApp(
      App()
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.teal,
      ),
      routes: {
        '/quiz': (context) => Quiz(),
      },
    );
  }
}