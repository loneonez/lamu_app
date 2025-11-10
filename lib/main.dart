import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:lamu_salary_app/screens/login_screen.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Firebase初期化を追加！
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ローカルに保存されたログイン情報をチェック
  final prefs = await SharedPreferences.getInstance();
  final savedCode = prefs.getString('employeeCode');
  final savedPass = prefs.getString('password');

  runApp(
    MyApp(
      isLoggedIn: savedCode != null && savedPass != null,
      employeeCode: savedCode,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? employeeCode;
  const MyApp({super.key, required this.isLoggedIn, this.employeeCode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAMU Staff Portal',
      home: isLoggedIn ? HomeScreen() : const LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
