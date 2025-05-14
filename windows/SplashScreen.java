import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../screens/home_screen.dart'; // عدّلها حسب اسم شاشة البداية بتاعتك

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // بعد 3 ثواني يروح على الشاشة الرئيسية
    Timer(Duration(seconds: 3), () {
      Get.off(() => HomeScreen()); // ← غيرها لاسم شاشتك الأساسية
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              width: size.width * 0.6,
              height: size.height * 0.3,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'METRO GO',
              style: TextStyle(
                fontFamily: 'Elephant',
                color: Color(0xFFCE5A5A),
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
