import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:lamu_salary_app/main.dart';

void main() {
  runApp(const Practice());
}

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: QrScreen());
  }
}

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: const [Text('×', style: TextStyle(fontSize: 50))]),
    );
  }
}
