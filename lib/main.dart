import 'package:flutter/material.dart';
import 'package:gallery/view/screens/home.dart';
import 'package:gallery/view/screens/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyHomePage(),
    },
    theme: ThemeData(
      useMaterial3: true,
    ),
  ));
}
