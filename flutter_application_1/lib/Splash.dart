import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final VoidCallback onPressed;
  const SplashPage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue, // 可以自定义背景颜色
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '欢迎使用',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('点击进入'),
            ),
          ],
        ),
      ),
    );
  }
}
