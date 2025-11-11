import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('大黒天物産')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(hintText: 'メールアドレスを入力してください'),
        ),
      ),
    );
  }
}
