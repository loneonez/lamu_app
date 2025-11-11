import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamu_salary_app/screens/homelistScreens/attendance_screen.dart';
import 'package:lamu_salary_app/screens/qrscreen.dart';
import 'package:lamu_salary_app/screens/account_screen.dart';
import 'package:lamu_salary_app/screens/homelistScreens/support_screen.dart';
import 'package:lamu_salary_app/screens/homelistScreens/team_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lamu_salary_app/screens/homelistScreens/mail_screen.dart';
import 'package:lamu_salary_app/screens/homelistScreens/shift_management.dart';
import 'package:lamu_salary_app/screens/homelistScreens/Statement_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; //現在の画面の値
  late List<Widget> _screens; //QR下のボタン集
  String currentTime = ""; //現在の時間
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _screens = [
      _HomeContent(
        onTapQr: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      const Qrscreen(),
      const AccountScreen(),
    ];

    //========================================================
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    if (!mounted) return;
    final now = DateTime.now();
    setState(() {
      currentTime =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    });
  }

  //====================================================
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('employeeCode');
    await prefs.remove('password');
    Navigator.pushReplacementNamed(context, '/login');
  }

  //画面下のナビゲーションバー================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[500],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Top'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: 'QR'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
        ],
      ),
    );
  }
}

//===================================================
// ホーム画面の中身部分
//===================================================
class _HomeContent extends StatelessWidget {
  final VoidCallback onTapQr;
  const _HomeContent({super.key, required this.onTapQr});

  // 6つのメニューをまとめて定義
  static final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.email, 'title': '業務メール', 'screen': const MailScreen()},
    {
      'icon': Icons.schedule,
      'title': 'シフト表',
      'screen': const ShiftmanagementScreen(),
    },
    {
      'icon': Icons.receipt_long,
      'title': '給与明細',
      'screen': const StatementScreen(),
    },
    {
      'icon': Icons.history,
      'title': '勤怠履歴',
      'screen': const AttendanceScreen(),
    },
    {'icon': Icons.people_alt, 'title': 'チーム情報', 'screen': const TeamScreen()},
    {
      'icon': Icons.support_agent,
      'title': 'サポート',
      'screen': const SupportScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40)),
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.notifications, size: 28, color: Colors.black),
              ),
              //QR画面==========================================
              const Padding(padding: EdgeInsets.only(top: 30)),
              GestureDetector(
                onTap: onTapQr,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: QrImageView(data: "employee_001", size: 100),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 20,
                        child: Text(
                          currentTime,
                          style: GoogleFonts.robotoMono(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 20,
                        child: Text(
                          "Tap ▶",
                          style: GoogleFonts.notoSansJp(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // メニューカード一覧=======================================
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _menuItems.map((item) {
                  return _buildMenuCard(item['icon'], item['title'], () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item['screen']),
                    );
                  });
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //===================================================
  // メニューカードWidget
  //===================================================
  static Widget _buildMenuCard(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.notoSansJp(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
