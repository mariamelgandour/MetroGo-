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
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../data/metro_lines.dart';
//
// class StationController extends GetxController {
//   var startStation = ''.obs;
//   var endStation = ''.obs;
//
//   // كل المحطات من كل الخطوط
//   final stationNames = <String>[].obs;
//
//   // خريطة علشان نعرف كل محطة بتنتمي لأنهي خط
//   final stationToLineMap = <String, String>{}.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadAllStations();
//   }
//
//   void loadAllStations() {
//     List<Map<String, dynamic>> allStations = [
//       ...MetroLines.line1.map((s) => {...s, 'line': 'First Line'}),
//       ...MetroLines.line2.map((s) => {...s, 'line': 'Second Line'}),
//       ...MetroLines.line3.map((s) => {...s, 'line': 'Third Line'}),
//     ];
//
//     stationNames.assignAll(
//       allStations.map((station) => station['name'] as String),
//     );
//
//     for (var station in allStations) {
//       stationToLineMap[station['name']] = station['line'];
//     }
//   }
//
//   String getLineOfStation(String stationName) {
//     return stationToLineMap[stationName] ?? '';
//   }
// }

import 'package:get/get.dart';
import '../data/metro_lines.dart';

class StationController extends GetxController {
  var startStation = ''.obs;
  var endStation = ''.obs;

  final stationNames = <String>[].obs;
  final stationToLineMap = <String, String>{}.obs;

  // خريطة تربط كل خط بمحطاته
  final Map<String, List<String>> lineStations = {
    'First Line': [],
    'Second Line': [],
    'Third Line': [],
  };

  // جميع المحطات التبادلية المعروفة بين الخطوط
  final Map<String, List<String>> transferStations = {
    'First Line-Second Line': [
      'التحرير',
      'السادات',
    ], // مثال لمحطتين تبادليتين بين الخط الأول والثاني
    'First Line-Third Line': [
      'الشهداء',
      'العتبة',
    ], // مثال لمحطتين تبادليتين بين الخط الأول والثالث
    'Second Line-Third Line': [
      'العتبة',
      'محطة جامعه القاهره',
    ], // مثال لمحطتين تبادليتين بين الخط الثاني والثالث
  };

  @override
  void onInit() {
    super.onInit();
    loadAllStations();
  }

  void loadAllStations() {
    List<Map<String, dynamic>> line1WithLine =
        MetroLines.line1.map((s) => {...s, 'line': 'First Line'}).toList();
    List<Map<String, dynamic>> line2WithLine =
        MetroLines.line2.map((s) => {...s, 'line': 'Second Line'}).toList();
    List<Map<String, dynamic>> line3WithLine =
        MetroLines.line3.map((s) => {...s, 'line': 'Third Line'}).toList();

    final allStations = [...line1WithLine, ...line2WithLine, ...line3WithLine];

    // أضيف أسماء المحطات للقائمة العامة
    stationNames.assignAll(
      Set<String>.from(
        allStations.map((stationNames) => stationNames['name'] as String),
      ),
    );

    // أعمل ماب تربط كل محطة بالخط اللي تابع ليه
    for (var station in allStations) {
      final name = station['name'];
      final line = station['line'];

      stationToLineMap[name] = line;
      if (!lineStations[line]!.contains(name)) {
        lineStations[line]!.add(name);
      }
    }
  }

  String getLineOfStation(String stationName) {
    return stationToLineMap[stationName] ?? '';
  }

  /// ✅ الدالة المعدلة لتحديد محطات التبديل
  String getTransferStation(String start, String end) {
    String startLine = getLineOfStation(start);
    String endLine = getLineOfStation(end);

    if (startLine.isEmpty || endLine.isEmpty) return 'إحدى المحطات غير معروفة';

    if (startLine == endLine) return 'المحطتان على نفس الخط ($startLine)';

    // نبحث عن المحطات التبادلية بين الخطين
    String transferKey = '$startLine-$endLine';
    List<String>? stations = transferStations[transferKey];

    // إذا لم نجد المحطات مباشرة، نجرب العكس
    if (stations == null) {
      transferKey = '$endLine-$startLine';
      stations = transferStations[transferKey];
    }

    if (stations != null && stations.isNotEmpty) {
      if (stations.length == 1) {
        return 'محطة التبديل: ${stations[0]} (من $startLine إلى $endLine)';
      } else {
        return 'محطات التبديل المتاحة: ${stations.join(' أو ')} (من $startLine إلى $endLine)';
      }
    }

    return 'لا يوجد محطات تبديل معروفة بين الخطين';
  }
}
