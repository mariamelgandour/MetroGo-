// import 'package:get/get.dart';
// import '../data/metro_lines.dart';
//
// class StationController extends GetxController {
//   var startStation = ''.obs;
//   var endStation = ''.obs;
//
//   // RxList علشان تقدر تتحدث ديناميك
//   final stationNames = <String>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadStations(); // استدعاء تحميل المحطات
//   }
//
//   void loadStations() {
//     // ضم كل أسماء المحطات من الخطوط التلاتة
//     final allStations = [
//       ...MetroLines.line1,
//       ...MetroLines.line2,
//       ...MetroLines.line3,
//     ];
//
//     // استخراج الاسم فقط
//     stationNames.assignAll(
//       allStations.map((station) => station['name'] as String),
//     );
//   }
// }
import 'package:get/get.dart';
import '../data/metro_lines.dart';

class StationController extends GetxController {
  var startStation = ''.obs;
  var endStation = ''.obs;
  var selectedLine = 'First Line'.obs;

  // RxList للمحطات الخاصة بالخط المحدد
  final stationNames = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStationsForLine(selectedLine.value); // تحميل محطات الخط الافتراضي
  }

  void loadStationsForLine(String line) {
    List<Map<String, dynamic>> stations;

    switch (line) {
      case 'First Line':
        stations = MetroLines.line1;
        break;
      case 'Second Line':
        stations = MetroLines.line2;
        break;
      case 'Third Line':
        stations = MetroLines.line3;
        break;
      default:
        stations = MetroLines.line1;
    }

    stationNames.assignAll(
      stations.map((station) => station['name'] as String),
    );
  }

  void updateSelectedLine(String line) {
    selectedLine.value = line;
    loadStationsForLine(line);
  }
}
