import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';
import 'package:lamu_salary_app/screens/forgot_passward_screen.dart';
import 'package:lamu_salary_app/screens/making_account.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _correctPassword = '1234';

  void _login() {
    final enteredPassword = _passwordController.text;

    if (enteredPassword == _correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('エラー'),
          content: const Text('パスワードが間違っています。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🧱 ←ここに固定フッターを設置
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Text(
          '給与・勤務情報ポータル',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '大黒天物産\nLAMU Staff Portal',
                style: GoogleFonts.mPlusRounded1c(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    const TextSpan(text: '社員コードまたはパスワードを忘れた場合\n'),
                    TextSpan(
                      text: 'こちら',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswardScreen(),
                            ),
                          );
                        },
                    ),
                    const TextSpan(text: 'をタップしてください'),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: 600,
                child: TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    hintText: '社員コードを入力（例：123456）',
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 600,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'パスワードを入力',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('ログイン'),
              ),
              //---------------------------------------------------------------
              Padding(
                padding: EdgeInsets.all(16),

                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      const TextSpan(text: '新規アカウント作成する方は'),
                      TextSpan(
                        text: 'こちら',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MakingAccount(),
                              ),
                            );
                          },
                      ),
                    ],
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
