import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'BottomNav.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Timer(Duration(seconds: 4), () {
      Get.off(() => BottomNavBar());
    });
  }
}

class SplashScreen extends GetView<SplashController> {
  @override
  final SplashController controller = Get.put(SplashController());

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
