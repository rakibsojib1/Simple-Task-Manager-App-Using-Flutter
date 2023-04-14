import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget widget;
  const Screen({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_screen_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          widget,
        ],
      ),
    );
  }
}
