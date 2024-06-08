import 'package:flutter/material.dart';
import 'package:flutter_bmkg_8040210115/detail_page.dart';
import 'package:flutter_bmkg_8040210115/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/detail-page':(context) => DetailPage(),
      },
    );
  }
}
