import 'package:get/get.dart';
import '../data/metro_lines.dart';

class LinesController extends GetxController {
  final RxString selectedLine = 'First Line'.obs;

  final List<String> rawLineKeys = ['first_line', 'second_line', 'third_line'];

  List<String> get linesNames => rawLineKeys.map((key) => key.tr).toList();

  Map<String, String> get linesTranslationMap => {
    'first_line'.tr: 'First Line',
    'second_line'.tr: 'Second Line',
    'third_line'.tr: 'Third Line',
  };

  RxString get lines => selectedLine;

  List<Map<String, dynamic>> getStationsForSelectedLine() {
    switch (selectedLine.value) {
      case 'First Line':
        return MetroLines.line1;
      case 'Second Liِne':
        return MetroLines.line2;
      case 'Third Line':
        return MetroLines.line3;
      default:
        return [];
    }
  }
}
