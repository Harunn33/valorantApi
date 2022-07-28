import 'package:flutter/material.dart';
import 'package:valorantapi/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorant API',
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
