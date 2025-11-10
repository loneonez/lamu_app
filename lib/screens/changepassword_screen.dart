import 'package:flutter/material.dart';

// パスワード入力の共通ウィジェット
class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: true, // パスワードを隠す
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              // ここに「パスワード表示切替」を入れることも可能
            },
          ),
        ),
      ),
    );
  }
}

class ChangepasswordScreen extends StatefulWidget {
  const ChangepasswordScreen({super.key});

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //shadowの高さ
        title: Row(
          children: const [
            Icon(Icons.lock, color: Colors.black),
            SizedBox(width: 10),
            Text(
              'パスワードを変更する',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 新しいパスワード
              SizedBox(
                width: 600,
                child: PasswordField(
                  controller: _newController,
                  label: '新しいパスワード',
                ),
              ),
              const SizedBox(height: 20),

              // 確認用パスワード
              SizedBox(
                width: 600,
                child: PasswordField(
                  controller: _confirmController,
                  label: '確認用パスワード',
                ),
              ),
              const SizedBox(height: 20),

              // 変更ボタン
              SizedBox(
                width: 600,
                child: ElevatedButton(
                  onPressed: () {
                    if (_newController.text == _confirmController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('パスワードを変更しました')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('パスワードが一致しません')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '変更',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
