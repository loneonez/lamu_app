import 'package:flutter/material.dart';
import 'package:lamu_salary_app/screens/login_screen.dart';

class MakingAccount extends StatefulWidget {
  const MakingAccount({super.key});

  @override
  State<MakingAccount> createState() => _MakingAccountState();
}

class _MakingAccountState extends State<MakingAccount> {
  final TextEditingController _newaccountController = TextEditingController();
  final TextEditingController _createcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '新規アカウント作成',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(hintText: 'new create mailadress'),
        ),
      ),
    );
  }
}
