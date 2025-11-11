import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:lamu_salary_app/screens/login_screen.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Firebase初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ローカルに保存された設定・ログイン情報を取得
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? false;
  final savedCode = prefs.getString('employeeCode');
  final savedPass = prefs.getString('password');

  runApp(
    MyApp(
      isDarkMode: isDark,
      isLoggedIn: savedCode != null && savedPass != null,
      employeeCode: savedCode,
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final String? employeeCode;
  final bool isDarkMode;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    this.employeeCode,
    required this.isDarkMode,
  });

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAMU Staff Portal',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: widget.isLoggedIn ? HomeScreen() : const LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
