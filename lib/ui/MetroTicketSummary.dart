import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/ui/Home_Page.dart';
import '../controllers/MetroController.dart';
import '../controllers/StationsController.dart';
import '../components/details.dart';
import '../components/custom_ticket_details.dart';
import '../data/metro_lines.dart';

class MetroTicketSummary extends StatelessWidget {
  final String start;
  final String end;
  final controller = Get.find<StationController>();

  final metroController = Get.put(MetroController());
  final Color transferColor = Colors.black;

  MetroTicketSummary({Key? key, required this.start, required this.end})
    : super(key: key);

  final StationController stationController = Get.find<StationController>();

  @override
  Widget build(BuildContext context) {
    final String transferInfo = stationController.getTransferStation(
      start,
      end,
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Color(0xff24242c) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Color(0xff24242c) : Colors.white,
        leading: IconButton(
          onPressed: () {
            controller.startStation.value = '';
            controller.endStation.value = '';
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: isDark ? Colors.white : Color(0xFF670D2F),
        ),
        // title: Text(
        //   'تفاصيل الرحلة',
        //   style: TextStyle(color: Color(0xFF670D2F)),
        // ),
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
                    text: 'stations_count'.trParams({
                      'count': metroController.stations.value.toString(),
                    }),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InfoCard(
                    icon: Icons.train,
                    text: 'minutes_count'.trParams({
                      'count': metroController.minutes.value.toString(),
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            DetailsContainer(
              text: 'route_from_to'.trParams({'start': start, 'end': end}),
              width: double.infinity,
              height: 80,
            ),
            const SizedBox(height: 16),
            DetailsContainer(
              text: 'no_transfer'.tr,
              width: double.infinity,
              height: 80,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: _buildTimelineRoute(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineRoute(var isDark) {
    final List<Map<String, dynamic>> fullStations = [
      ...MetroLines.line1,
      ...MetroLines.line2,
      ...MetroLines.line3,
    ];

    final List<String> route = controller.getRoute(start, end);
    final transferStations = controller.getTransferStations(start, end);

    final bool isSameLine =
        controller.getLineOfStation(start) == controller.getLineOfStation(end);
    final Color sameLineColor = _getLineColor(
      controller.getLineOfStation(start),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            for (int i = 0; i < route.length; i++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color:
                              isSameLine
                                  ? sameLineColor
                                  : transferStations.contains(route[i])
                                  ? transferColor
                                  : _getLineColor(
                                    controller.getLineOfStation(route[i]),
                                  ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (i != route.length - 1)
                        Container(
                          width: 2,
                          height: 40,
                          color:
                              isSameLine
                                  ? sameLineColor
                                  : _getLineColor(
                                    controller.getLineOfStation(route[i]),
                                  ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        route[i],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
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
}
