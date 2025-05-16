import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../data/metro_lines.dart';

class StationController extends GetxController {
  var startStation = ''.obs;
  var endStation = ''.obs;

  final selectedLine = 'First Line'.obs;

  final stationNames = <String>[].obs;
  final stationToLineMap = <String, String>{}.obs;

  final Map<String, List<String>> lineStations = {
    'First Line': [],
    'Second Line': [],
    'Third Line': [],
  };

  final Map<String, List<String>> transferStations = {
    'First Line-Second Line': ['Sadat', 'Al Shohadaa'],
    'First Line-Third Line': ['Gamal Abd Al_Nasser'],
    'Second Line-Third Line': ['Attaba'],
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

    stationNames.assignAll(
      Set<String>.from(allStations.map((station) => station['name'] as String)),
    );

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

  String _translateStationName(String station) {
    final line = getLineOfStation(station);
    final linePrefix = line.toLowerCase().replaceAll(' ', '_');
    final key = '${linePrefix}_${station.toLowerCase().replaceAll(' ', '_')}';
    return key.tr;
  }

  void updateSelectedLine(String line) {
    selectedLine.value = line;
  }

  String getTransferStation(String start, String end) {
    String startLine = getLineOfStation(start);
    String endLine = getLineOfStation(end);

    if (startLine.isEmpty || endLine.isEmpty) return 'إحدى المحطات غير معروفة';
    if (startLine == endLine) {
      return 'المحطتان على نفس الخط (${startLine.tr})';
    }

    String transferKey = '$startLine-$endLine';
    List<String>? stations = transferStations[transferKey];

    if (stations == null) {
      transferKey = '$endLine-$startLine';
      stations = transferStations[transferKey];
    }

    if (stations != null && stations.isNotEmpty) {
      if (stations.length == 1) {
        return 'محطة التبديل: ${_translateStationName(stations[0])} (من ${startLine.tr} إلى ${endLine.tr})';
      } else {
        final translated = stations.map(_translateStationName).join(' أو ');
        return 'محطات التبديل المتاحة: $translated (من ${startLine.tr} إلى ${endLine.tr})';
      }
    }

    return 'لا يوجد محطات تبديل معروفة بين الخطين';
  }

  List<String> getRoute(String start, String end) {
    List<String> visited = [];
    List<String> queue = [start];
    Map<String, String?> parent = {start: null};

    while (queue.isNotEmpty) {
      String current = queue.removeAt(0);
      if (current == end) break;

      visited.add(current);
      List<String> neighbors = _getConnectedStations(current);

      for (String neighbor in neighbors) {
        if (!visited.contains(neighbor) && !queue.contains(neighbor)) {
          parent[neighbor] = current;
          queue.add(neighbor);
        }
      }
    }

    List<String> path = [];
    String? step = end;
    while (step != null) {
      path.insert(0, _translateStationName(step));
      step = parent[step];
    }

    return path;
  }

  List<String> getTransferStations(String start, String end) {
    List<String> path = getRoute(start, end);
    List<String> transfers = [];

    for (int i = 1; i < path.length - 1; i++) {
      String originalName = _getOriginalStationName(path[i]);
      String currentLine = getLineOfStation(originalName);
      String prevLine = getLineOfStation(_getOriginalStationName(path[i - 1]));
      String nextLine = getLineOfStation(_getOriginalStationName(path[i + 1]));

      if (currentLine != prevLine || currentLine != nextLine) {
        if (!transfers.contains(path[i])) {
          transfers.add(path[i]);
        }
      }
    }

    return transfers;
  }

  /// استرجاع اسم المحطة الأصلي قبل الترجمة
  String _getOriginalStationName(String translated) {
    return stationNames.firstWhere(
      (name) => _translateStationName(name) == translated,
      orElse: () => translated,
    );
  }

  List<String> _getConnectedStations(String station) {
    List<String> neighbors = [];

    void addNeighbors(List<Map<String, dynamic>> line) {
      for (int i = 0; i < line.length; i++) {
        if (line[i]['name'] == station) {
          if (i > 0) neighbors.add(line[i - 1]['name']);
          if (i < line.length - 1) neighbors.add(line[i + 1]['name']);
        }
      }
    }

    addNeighbors(MetroLines.line1);
    addNeighbors(MetroLines.line2);
    addNeighbors(MetroLines.line3);

    return neighbors;
  }
}
