import 'package:flutter/material.dart';

import '../components/custom_settings_page.dart';
import '../components/customdropdownsettings.dart';

class SettingsPage extends StatelessWidget {
  final String selectedLanguage = 'ar';
  final String selectedTheme = 'light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30), // حواف معقولة
                    child: Container(
                      width: 130, // العرض
                      height: 130, // الطول
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),
              LanguageThemeSelector(
                selectedLanguage: selectedLanguage,
                selectedTheme: selectedTheme,
                onLanguageChanged: (val) {},
                onThemeChanged: (val) {},
              ),

              SizedBox(height: 24),

              StyledBoxList(
                items: const [
                  "📱Rate Us on Google Play",
                  "ℹ️ about app",
                  "👨‍💻 about developers",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
