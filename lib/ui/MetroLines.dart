// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../components/custom_DropDownMenu.dart';
// import '../controllers/StationsController.dart';
// import '../controllers/linesController.dart';
// import '../data/metro_lines.dart';
//
// class Metrolines extends StatelessWidget {
//   final String imagePath;
//   final controller = Get.put(Linescontroller());
//   final stationController = Get.put(StationController());
//
//   Metrolines({required this.imagePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder:
//                     (_) => Dialog(
//                       insetPadding: EdgeInsets.all(10),
//                       child: InteractiveViewer(
//                         child: Image.asset(imagePath, fit: BoxFit.contain),
//                       ),
//                     ),
//               );
//             },
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Center(
//                   child: Image.asset(
//                     imagePath,
//                     height: 100,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Card(
//             elevation: 4,
//             margin: const EdgeInsets.all(20),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(30),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CustomDropdownmenu(
//                     label: 'اختر خط المترو',
//                     selectedValue: controller.lines,
//                     options: controller.linesNames,
//                     onChanged: (value) {
//                       controller.lines.value = value;
//                       stationController.updateSelectedLine(value);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Obx(() => _buildTimeline(stationController.selectedLine.value)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTimeline(String selectedLine) {
//     List<Map<String, dynamic>> stations = [];
//
//     switch (selectedLine) {
//       case 'First Line':
//         stations = MetroLines.line1;
//         break;
//       case 'Second Line':
//         stations = MetroLines.line2;
//         break;
//       case 'Third Line':
//         stations = MetroLines.line3;
//         break;
//       default:
//         stations = MetroLines.line1;
//     }
//
//     return Container(
//       height: 250,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             for (int i = 0; i < stations.length; i++)
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 textDirection: TextDirection.rtl, // <-- الاتجاه من اليمين
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         width: 12,
//                         height: 12,
//                         decoration: BoxDecoration(
//                           color: _getLineColor(selectedLine),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       if (i != stations.length - 1)
//                         Container(
//                           width: 2,
//                           height: 40,
//                           color: _getLineColor(selectedLine),
//                         ),
//                     ],
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 2.0),
//                       child: Text(
//                         stations[i]['name'],
//                         textAlign: TextAlign.right, // <-- النص يبدأ من اليمين
//                         style: TextStyle(fontSize: 14, color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getLineColor(String line) {
//     switch (line) {
//       case 'First Line':
//         return Colors.red;
//       case 'Second Line':
//         return Colors.blue;
//       case 'Third Line':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/custom_DropDownMenu.dart';
import '../controllers/StationsController.dart';
import '../controllers/linesController.dart';
import '../data/metro_lines.dart';

class Metrolines extends StatelessWidget {
  final String imagePath;
  final controller = Get.put(Linescontroller());
  final stationController = Get.put(StationController());

  Metrolines({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                child: Center(
                  child: Image.asset(
                    imagePath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Card(
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
                    label: 'اختر خط المترو',
                    selectedValue: controller.lines,
                    options: controller.linesNames,
                    onChanged: (value) {
                      controller.lines.value = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          Obx(() => _buildTimeline(controller.lines.value)),
        ],
      ),
    );
  }

  Widget _buildTimeline(String selectedLine) {
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
        stations = MetroLines.line1;
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
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
                        stations[i]['name'],
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
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
