import 'package:flutter/material.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';
import 'package:lamu_salary_app/screens/qrscreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('追加')));
  }
}
