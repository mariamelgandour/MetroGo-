import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/ui/Home_Page.dart';
import 'dart:async';

import 'BottomNav.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // بعد 3 ثواني يروح على الشاشة الرئيسية
    Timer(Duration(seconds: 4), () {
      Get.off(() => BottomNavBar()); // ← غيرها لاسم شاشتك الأساسية
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfffff3f3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.jpg',
              width: size.width * 0.7,
              height: size.height * 0.3,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'METRO GO',
              style: TextStyle(
                fontFamily: 'Elephant',
                color: Color(0xFF7b011c),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
