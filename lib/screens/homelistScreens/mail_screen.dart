import 'package:flutter/material.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  @override
  Widget build(BuildContext context) {
    // 👇ここでcontextを使う！
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05, // 高さの5%
          left: screenWidth * 0.05, // 幅の5%
          right: screenWidth * 0.05,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Mail',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Align(alignment: Alignment.topRight, child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
