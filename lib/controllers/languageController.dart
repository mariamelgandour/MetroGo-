import 'dart:ui';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'en'.obs;

  Locale get currentLocale => Locale(selectedLanguage.value);

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
    Get.updateLocale(Locale(lang));
  }
}
