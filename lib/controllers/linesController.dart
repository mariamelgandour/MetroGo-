// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// class Linescontroller extends GetxController {
//   var lines = ''.obs;
//   final linesNames = ['First Line', 'Second Line', 'Third Line'];
// }
import 'package:get/get.dart';
import '../data/metro_lines.dart';

class Linescontroller extends GetxController {
  final RxString selectedLine = 'Line 1'.obs;
  final List<String> linesNames = ['Line 1', 'Line 2', 'Line 3'];

  // إضافة getter للوصول إلى القيمة كـ RxString
  RxString get lines => selectedLine;

  List<Map<String, dynamic>> getStationsForSelectedLine() {
    switch (selectedLine.value) {
      case 'Line 1':
        return MetroLines.line1;
      case 'Line 2':
        return MetroLines.line2;
      case 'Line 3':
        return MetroLines.line3;
      default:
        return MetroLines.line1;
    }
  }
}
