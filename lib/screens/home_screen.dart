import 'package:flutter/material.dart';
import 'package:lamu_salary_app/screens/Statement_screen.dart';
import 'package:lamu_salary_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ホバー状態を管理
  final Map<String, bool> _isHovering = {
    'statement': false,
    'loginPassword': false,
    'statementPassword': false,
    'notice': false,
    'logout': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(16)),
          const Text(
            '大黒天物産株式会社\n給与・賞与明細書',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // 1行目（明細書を見る）
          _buildHoverRow(
            keyName: 'statement',
            icon: Icons.description,
            text: '明細書を見る',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatementScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 30),

          // 2行目（ログインパスワードの変更）
          _buildHoverRow(
            keyName: 'loginPassword',
            icon: Icons.lock_outline,
            text: 'ログインパスワードの変更',
            onTap: () {
              // 遷移処理を書く
            },
          ),
          const SizedBox(height: 30),

          // 3行目（明細書パスワードの変更）
          _buildHoverRow(
            keyName: 'statementPassword',
            icon: Icons.receipt_long_outlined,
            text: '明細書パスワードの変更',
            onTap: () {
              // 遷移処理を書く
            },
          ),
          const SizedBox(height: 30),

          // 4行目（お知らせ）
          _buildHoverRow(
            keyName: 'notice',
            icon: Icons.notifications_none,
            text: 'お知らせ',
            onTap: () {
              // 遷移処理を書く
            },
          ),
          const SizedBox(height: 30),

          // 5行目（ログアウト）
          _buildHoverRow(
            keyName: 'logout',
            icon: Icons.logout,
            text: 'ログアウト',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHoverRow({
    required String keyName,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    final isHovering = _isHovering[keyName] ?? false;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering[keyName] = true),
      onExit: (_) => setState(() => _isHovering[keyName] = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isHovering ? Colors.red : Colors.blue),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isHovering ? Colors.red : Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
