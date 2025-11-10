import 'package:flutter/material.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';
import 'package:lamu_salary_app/screens/qrscreen.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomeScreen());
  }
}
