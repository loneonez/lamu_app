import 'package:flutter/material.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.description, color: Colors.black),
            SizedBox(width: 10),
            Text(
              '明細書一覧',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 横中央
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '○○様',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                '明細書を選択し、閲覧したい形式のボタンを押してください！',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),

              // PDF形式カード
              SizedBox(
                width: 400,
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      // PDF閲覧画面への遷移処理
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.picture_as_pdf,
                            size: 30,
                            color: Colors.red,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'PDF形式で見る',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 表形式カード
              SizedBox(
                width: 400,
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      // 表形式閲覧画面への遷移処理
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: const [
                          Icon(Icons.grid_view, size: 30, color: Colors.blue),
                          SizedBox(width: 20),
                          Text(
                            '表形式で見る',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
