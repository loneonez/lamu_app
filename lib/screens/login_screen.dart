import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';
import 'package:lamu_salary_app/screens/forgot_passward_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isButtonEnabled = false;
  final String _url = 'https://www.e-dkt.co.jp/';

  //TODO==============================================
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _codeController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  // 自動ログインチェック
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('employeeCode');
    final pass = prefs.getString('password');

    if (code != null && pass != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  // 入力が両方あるか確認してボタン状態更新
  void _updateButtonState() {
    final isFilled =
        _codeController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    setState(() {
      _isButtonEnabled = isFilled;
    });
  }

  // Firestoreログイン処理
  Future<void> _login() async {
    final enteredCode = _codeController.text.trim();
    final enteredPassword = _passwordController.text.trim();

    try {
      final doc = await FirebaseFirestore.instance
          .collection('employees')
          .doc(enteredCode)
          .get();

      if (!doc.exists) {
        _showErrorDialog('社員コードが存在しません。');
        return;
      }

      final data = doc.data();
      final correctPassword = data?['password'];

      if (enteredPassword == correctPassword) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('employeeCode', enteredCode);
        await prefs.setString('password', enteredPassword);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        _showErrorDialog('パスワードが間違っています。');
      }
    } catch (e) {
      _showErrorDialog('ログイン中にエラーが発生しました: $e');
    }
  }

  // URL開く
  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(_url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('URLを開けませんでした');
    }
  }

  // エラーダイアログ
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('エラー'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // タイトル
                Center(
                  child: Text(
                    'Login',
                    style: GoogleFonts.mPlusRounded1c(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 忘れた場合リンク
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        const TextSpan(text: '社員コードまたはパスワードを忘れた場合\n'),
                        WidgetSpan(
                          child: _HoverableText(
                            text: 'こちら',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswardScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const TextSpan(text: 'をタップしてください'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 社員コード
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    'Code',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    hintText: '社員コードを入力（例：123456）',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 30),

                // パスワード
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    'Password',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'パスワードを入力',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onSubmitted: (_) {
                    if (_isButtonEnabled) {
                      _login(); //Enterキーでログイン
                    }
                  },
                ),

                const SizedBox(height: 40),

                // ログインボタン
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled ? _login : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonEnabled
                          ? Colors.black
                          : Colors.grey[300],
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('ログイン'),
                  ),
                ),
                const SizedBox(height: 20),

                // 公式サイトリンク
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        const TextSpan(text: '公式サイトは'),
                        TextSpan(
                          text: 'こちら',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _launchUrl,
                        ),
                        const TextSpan(text: 'からアクセスできます。'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Hover対応テキストウィジェット
class _HoverableText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _HoverableText({required this.text, required this.onTap, super.key});

  @override
  State<_HoverableText> createState() => _HoverableTextState();
}

class _HoverableTextState extends State<_HoverableText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isHovering ? Colors.black : Colors.grey,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
