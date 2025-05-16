import 'package:get/get.dart';
import '../data/metro_lines.dart';

class MetroController extends GetxController {
  var stations = 0.obs;
  var minutes = 0.obs;
  var price = 0.obs;
  final transferStations = <String>[].obs;

  void updateValues({
    required int newStations,
    required int newMinutes,
    required double newPrice,
  }) {
    stations.value = newStations;
    minutes.value = newMinutes;
    price.value = newPrice.toInt();
  }

  // كل المحطات وعلاقتها ببعض (ببساطة خريطة)
  Map<String, List<String>> _buildGraph() {
    final graph = <String, List<String>>{};

    List<List<Map<String, dynamic>>> allLines = [
      MetroLines.line1,
      MetroLines.line2,
      MetroLines.line3,
    ];

    for (var line in allLines) {
      for (int i = 0; i < line.length - 1; i++) {
        String current = line[i]['name'];
        String next = line[i + 1]['name'];

        graph.putIfAbsent(current, () => []);
        graph.putIfAbsent(next, () => []);

        graph[current]!.add(next);
        graph[next]!.add(current);
      }
    }

    return graph;
  }

  List<String> findPathBetweenStations(String start, String end) {
    final graph = _buildGraph();
    final queue = <List<String>>[];
    final visited = <String>{};

    queue.add([start]);
    visited.add(start);

    while (queue.isNotEmpty) {
      final path = queue.removeAt(0);
      final last = path.last;

      if (last == end) return path;

      for (var neighbor in graph[last]!) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add([...path, neighbor]);
        }
      }
    }

    return [];
  }

  int calculateStationsBetween(String start, String end) {
    final path = findPathBetweenStations(start, end);
    if (path.isEmpty) return -1;

    transferStations.clear();
    List<List<Map<String, dynamic>>> allLines = [
      MetroLines.line1,
      MetroLines.line2,
      MetroLines.line3,
    ];

    for (int i = 1; i < path.length - 1; i++) {
      int foundIn = 0;
      for (var line in allLines) {
        if (line.any((station) => station['name'] == path[i])) {
          foundIn++;
        }
      }
      if (foundIn > 1) {
        transferStations.addIf(!transferStations.contains(path[i]), path[i]);
      }
    }

    return path.length - 1;
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
