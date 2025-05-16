import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colorTheme.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeData get currentTheme =>
      isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeTheme(currentTheme);
  }
}
