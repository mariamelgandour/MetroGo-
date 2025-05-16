import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/custom_DropDownMenu.dart';
import '../controllers/StationsController.dart';
import '../controllers/linesController.dart';
import '../data/metro_lines.dart';

class Metrolines extends StatelessWidget {
  final String imagePath;
  final controller = Get.put(LinesController());
  final stationController = Get.put(StationController());

  Metrolines({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    controller.lines.value = '';
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(
          context,
        ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => Dialog(
                        insetPadding: EdgeInsets.all(10),
                        child: InteractiveViewer(
                          child: Image.asset(imagePath, fit: BoxFit.contain),
                        ),
                      ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.asset(
                        imagePath,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 33,
                        right: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Center(
                            child: Icon(
                              Icons.zoom_in_map,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Card(
              color: isDark ? Color(0xff393E46) : Colors.grey[200],
              elevation: 4,
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownmenu(
                      label: 'select_line'.tr,
                      text: 'select_line'.tr,
                      hintMassage: true,
                      hintText: 'select_line'.tr,
                      selectedValue: controller.lines,
                      options: controller.linesNames,
                      onChanged: (value) {
                        controller.lines.value = value;
                        final originalLine =
                            controller.linesTranslationMap[value] ?? value;
                        stationController.updateSelectedLine(originalLine);
                      },
                    ),
                  ],
                ),
              ),
            ),

            Obx(() {
              if (controller.lines.value != '')
                return SizedBox(
                  height: 200,
                  child: Obx(
                    () => SingleChildScrollView(
                      child: _buildTimeline(
                        stationController.selectedLine.value,
                        isDark,
                      ),
                    ),
                  ),
                );
              return const SizedBox(height: 0, width: 0);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(String selectedLine, var isDark) {
    List<Map<String, dynamic>> stations = [];

    switch (selectedLine) {
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
        stations = [];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          for (int i = 0; i < stations.length; i++)
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
                        color: _getLineColor(selectedLine),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (i != stations.length - 1)
                      Container(
                        width: 2,
                        height: 40,
                        color: _getLineColor(selectedLine),
                      ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      stations[i]['name'].toString().tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white : Color(0xFF670D2F),
                      ),
                    ),
                  ),
                ),
              ],
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
}
