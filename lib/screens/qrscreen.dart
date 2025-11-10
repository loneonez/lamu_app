import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrscreen extends StatelessWidget {
  const Qrscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景
          Container(color: Colors.white),

          // 左上の×ボタン
          Positioned(
            top: 20,
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
              padding: const EdgeInsets.only(top: 20),
              child: const Text('QRコードをかざす', style: TextStyle(fontSize: 20)),
            ),
          ),

          // 中央のQRコードエリア
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 220,
              height: 220,
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
              child: Center(
                child: QrImageView(data: "employee_001", size: 180),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
