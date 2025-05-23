import 'package:flutter/material.dart';

class LanguageThemeSelector extends StatelessWidget {
  final String selectedLanguage;
  final String selectedTheme;
  final Function(String?) onLanguageChanged;
  final Function(String?) onThemeChanged;

  const LanguageThemeSelector({
    super.key,
    required this.selectedLanguage,
    required this.selectedTheme,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedLanguage,
            decoration: const InputDecoration(
              labelText: 'اللغة',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA53860), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            items: const [
              DropdownMenuItem(value: 'ar', child: Text('العربية')),
              DropdownMenuItem(value: 'en', child: Text('English')),
            ],
            onChanged: onLanguageChanged,
          ),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedTheme,
            decoration: const InputDecoration(
              labelText: 'الثيم',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA53860), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            items: const [
              DropdownMenuItem(value: 'light', child: Text('فاتح')),
              DropdownMenuItem(value: 'dark', child: Text('داكن')),
            ],
            onChanged: onThemeChanged,
          ),
        ),
      ],
    );
  }
}
