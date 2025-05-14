import 'package:get/get.dart';

import '../data/metro_lines.dart';

class MetroController extends GetxController {
  var stations = 0.obs;
  var minutes = 0.obs;
  var price = 0.obs;

  void updateValues({
    required int newStations,
    required int newMinutes,
    required double newPrice,
  }) {
    stations.value = newStations;
    minutes.value = newMinutes;
    price.value = newPrice.toInt();
  }

  int calculateStationsBetween(String start, String end) {
    List<List<Map<String, dynamic>>> allLines = [
      MetroLines.line1,
      MetroLines.line2,
      MetroLines.line3,
    ];

    for (var line in allLines) {
      final names = line.map((e) => e["name"] as String).toList();
      if (names.contains(start) && names.contains(end)) {
        int startIndex = names.indexOf(start);
        int endIndex = names.indexOf(end);
        return (startIndex - endIndex).abs();
      }
    }
    return -1; // not found on same line
  }

  int calculateTime(int stationCount) {
    return stationCount * 2;
  }

  double calculatePrice(int stationCount) {
    if (stationCount <= 9) return 8;
    if (stationCount <= 16) return 10;
    if (stationCount <= 23) return 15;
    return 20;
  }

  double calculateTotalPrice(int stationCount, int individuals) {
    return calculatePrice(stationCount) * individuals;
  }
}
