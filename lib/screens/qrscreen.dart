import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamu_salary_app/screens/account_screen.dart';
import 'package:lamu_salary_app/screens/home_screen.dart';

class Qrscreen extends StatefulWidget {
  const Qrscreen({super.key});

  @override
  State<Qrscreen> createState() => _QrscreenState();
}

class _QrscreenState extends State<Qrscreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景
          Container(color: Colors.white),

          // 左上の×ボタン
          Positioned(
            top: 60,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // 戻る処理
              },
              child: const Icon(Icons.close, size: 28),
            ),
          ),

          // 上部中央のテキスト
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: const Text('QRコードをかざす', style: TextStyle(fontSize: 20)),
            ),
          ),

          // 中央のQRコードエリア
          FractionallySizedBox(
            widthFactor: 1, //親のcenterと同じ位置
            heightFactor: 0.7, // 画面高さの50%位置に
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: QrImageView(data: "employee_001", size: 180),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Top'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2, size: 30),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            label: 'アカウント',
          ),
        ],
      ),
    );
  }
}
