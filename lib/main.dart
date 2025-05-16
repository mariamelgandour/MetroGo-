import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/themeController.dart';
import 'controllers/languageController.dart';
import 'ui/splash_screen.dart';
import 'colorTheme.dart';
import 'translations.dart';

void main() {
  Get.put(ThemeController());
  Get.put(LanguageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final LanguageController langController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: langController.currentLocale,
        fallbackLocale: Locale('en'),
        theme: themeController.currentTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,

        home: SplashScreen(),
      ),
    );
  }
}
