import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/components/details.dart';

import '../components/custom_DropDownMenu.dart';
import '../components/custom_ticket_details.dart';
import '../controllers/MetroController.dart';
import '../controllers/StationsController.dart';

class TicketPrice extends StatelessWidget {
  final controller = Get.put(StationController());
  final metroController = Get.put(MetroController());
  final count = 0.obs;
  final showSummary = false.obs;
  final needSwitch = false.obs;
  late int stations;

  @override
  Widget build(BuildContext context) {
    controller.startStation.value = '';
    controller.endStation.value = '';
    count.value = 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(
      () => Column(
        children: [
          Card(
            elevation: 4,
            color: isDark ? Color(0xff393E46) : Colors.grey[200],
            margin: EdgeInsets.all(screenWidth * 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropdownmenu(
                    label: 'start_station'.tr,
                    text: 'select_station'.tr,
                    hintMassage: false,
                    selectedValue: controller.startStation,
                    options: controller.stationNames,
                    onChanged: (value) {
                      controller.startStation.value = value;
                      showSummary.value = false;
                      if (controller.endStation.value.isNotEmpty) {
                        needSwitch.value =
                            controller.getLineOfStation(value) !=
                            controller.getLineOfStation(
                              controller.endStation.value,
                            );
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomDropdownmenu(
                    label: 'end_station'.tr,
                    text: 'select_station'.tr,
                    hintMassage: false,
                    selectedValue: controller.endStation,
                    options: controller.stationNames,
                    onChanged: (value) {
                      controller.endStation.value = value;
                      showSummary.value = false;
                      if (controller.startStation.value.isNotEmpty) {
                        needSwitch.value =
                            controller.getLineOfStation(value) !=
                            controller.getLineOfStation(
                              controller.startStation.value,
                            );
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.white : Color(0xFF670D2F),
                        width: 2,
                      ),
                      color: isDark ? Color(0xff393E46) : Colors.grey[200],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Text(
                            'number_of_individuals'.tr,
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF670D2F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () => count.value++,
                            icon: Icon(
                              Icons.add,
                              color: isDark ? Colors.white : Color(0xff24242c),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            '${count.value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                              color: isDark ? Colors.white : Color(0xff24242c),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              if (count.value > 0) count.value--;
                            },
                            icon: Icon(
                              Icons.remove,
                              color: isDark ? Colors.white : Color(0xff24242c),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF670D2F),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      onPressed: () {
                        final start = controller.startStation.value;
                        final end = controller.endStation.value;
                        final individuals = count.value;

                        if (start == '' || end == '') {
                          Get.snackbar(
                            'error'.tr,
                            'choose_two_stations'.tr,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        final sameLine =
                            controller.getLineOfStation(start) ==
                            controller.getLineOfStation(end);
                        needSwitch.value = !sameLine;

                        stations = metroController.calculateStationsBetween(
                          start,
                          end,
                        );

                        int minutes = metroController.calculateTime(stations);
                        double totalPrice = metroController.calculateTotalPrice(
                          stations,
                          individuals,
                        );

                        metroController.updateValues(
                          newStations: stations,
                          newMinutes: minutes,
                          newPrice: totalPrice,
                        );

                        showSummary.value = true;
                      },
                      child: Text('count'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showSummary.value) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.access_time,
                          text:
                              '${metroController.minutes.value} ${'minutes'.tr}',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.train,
                          text:
                              '${metroController.stations.value} ${'stations'.tr}',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  DetailsContainer(
                    text:
                        '${'total_amount'.tr}: ${metroController.price.value} ${'currency'.tr}',
                    height: 40,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
