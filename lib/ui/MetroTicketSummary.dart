import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/MetroController.dart';
import '../controllers/StationsController.dart';
import '../components/details.dart';
import '../components/custom_ticket_details.dart';

class MetroTicketSummary extends StatelessWidget {
  final String start;
  final String end;

  final controller = Get.find<StationController>();
  final metroController = Get.put(MetroController());

  MetroTicketSummary({Key? key, required this.start, required this.end})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allPaths = metroController.findAllPathsBetweenStations(start, end);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff24242c) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Color(0xff24242c) : Colors.white,
        leading: IconButton(
          onPressed: () {
            controller.startStation.value = '';
            controller.endStation.value = '';
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: isDark ? Colors.white : const Color(0xFF670D2F),
        ),
        title: Text(
          'summary_title'.tr,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    icon: Icons.access_time,
                    text: '${metroController.minutes.value} ${'minutes'.tr}',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InfoCard(
                    icon: Icons.train,
                    text: '${metroController.stations.value} ${'stations'.tr}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            DetailsContainer(
              text: '$start ${'to'.tr} $end',

              width: double.infinity,
              height: 80,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: allPaths.length,
                itemBuilder: (context, index) {
                  final path = allPaths[index];
                  final transferDescription = _buildTransfersDescription(path);

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: isDark ? Color(0xff24242c) : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'path'.tr} ${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            transferDescription,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 10),
                          for (int i = 0; i < path.length; i++)
                            _buildStationRow(path, i, isDark),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationRow(List<String> path, int index, bool isDark) {
    final station = path[index];
    final currentLine = controller.getLineOfStation(station);
    final previousLine =
        index > 0 ? controller.getLineOfStation(path[index - 1]) : currentLine;
    final bool isTransfer = index > 0 && currentLine != previousLine;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 10, color: _getLineColor(currentLine)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isTransfer
                      ? 'transfer_to'.trParams({'line': currentLine})
                      : 'same_line'.trParams({'line': currentLine}),
                  style: TextStyle(
                    fontSize: 12,
                    color: isTransfer ? Colors.orange : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getLineColor(String line) {
    switch (line) {
      case 'First Line':
        return Colors.red;
      case 'Second Line':
        return Colors.blue;
      case 'Third Line':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _buildTransfersDescription(List<String> path) {
    final transfers = <String>{};

    for (int i = 1; i < path.length; i++) {
      final prevLine = controller.getLineOfStation(path[i - 1]);
      final currLine = controller.getLineOfStation(path[i]);
      if (prevLine != currLine) {
        transfers.add(path[i]);
      }
    }

    if (transfers.isEmpty) {
      return 'no_transfer'.tr;
    } else {
      return 'transfer_station'.trParams({'station': transfers.join(', ')});
    }
  }
}
