import 'package:get/get.dart';
import '../data/metro_lines.dart';
import 'StationsController.dart';

class MetroController extends GetxController {
  var stations = 0.obs;
  var minutes = 0.obs;
  var price = 0.obs;

  final transferStations = <String>[].obs;

  final StationController stationController = Get.find<StationController>();

  void updateValues({
    required int newStations,
    required int newMinutes,
    required double newPrice,
  }) {
    stations.value = newStations;
    minutes.value = newMinutes;
    price.value = newPrice.toInt();
  }

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
    final shortestPath = getShortestPath(start, end);
    if (shortestPath.isEmpty) return -1;

    transferStations.clear();

    for (int i = 1; i < shortestPath.length - 1; i++) {
      final prev = shortestPath[i - 1];
      final current = shortestPath[i];
      final next = shortestPath[i + 1];

      final prevLine = stationController.getLineOfStation(prev);
      final currLine = stationController.getLineOfStation(current);
      final nextLine = stationController.getLineOfStation(next);

      if ((currLine != prevLine || currLine != nextLine) &&
          !transferStations.contains(current)) {
        transferStations.add(current);
      }
    }

    return shortestPath.length - 1;
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

  List<List<String>> findAllPathsBetweenStations(String start, String end) {
    final graph = _buildGraph();
    final allPaths = <List<String>>[];

    void dfs(String current, List<String> path) {
      if (current == end) {
        allPaths.add(List.from(path));
        return;
      }

      for (var neighbor in graph[current] ?? []) {
        if (!path.contains(neighbor)) {
          path.add(neighbor);
          dfs(neighbor, path);
          path.removeLast();
        }
      }
    }

    dfs(start, [start]);
    return allPaths;
  }

  List<String> getShortestPath(String start, String end) {
    final allPaths = findAllPathsBetweenStations(start, end);
    if (allPaths.isEmpty) return [];
    allPaths.sort((a, b) => a.length.compareTo(b.length));
    return allPaths.first;
  }

  String _buildTransfersDescription(List<String> path) {
    final transfers = <String>{};

    for (int i = 1; i < path.length; i++) {
      final prevLine = stationController.getLineOfStation(path[i - 1]);
      final currLine = stationController.getLineOfStation(path[i]);
      if (prevLine != currLine) {
        transfers.add(path[i]);
      }
    }

    if (transfers.isEmpty) {
      return 'لا يوجد تبديل، المسار على نفس الخط';
    } else {
      return 'محطة التبديل: ${transfers.join(', ')}';
    }
  }

  String getTransfersDescription(List<String> path) {
    return _buildTransfersDescription(path);
  }
}
