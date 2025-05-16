import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/themeController.dart';
import '../controllers/languageController.dart';

class SettingsPage extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => SwitchListTile(
                title: Text('dark_mode'.tr),
                value: themeController.isDarkMode.value,
                onChanged: (val) {
                  themeController.toggleTheme(val);
                },
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => DropdownButton<String>(
                value: languageController.selectedLanguage.value,
                items: [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                ],
                onChanged: (val) {
                  if (val != null) {
                    languageController.selectedLanguage.value = val;
                    final locale = Locale(val, val.toUpperCase());
                    Get.updateLocale(locale);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
