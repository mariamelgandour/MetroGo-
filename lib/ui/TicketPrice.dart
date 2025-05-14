import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/custom_DropDownMenu.dart';
import '../controllers/MetroController.dart';
import '../controllers/StationsController.dart';

class TicketPrice extends StatelessWidget {
  final controller = Get.put(StationController());
  final metroController = Get.put(MetroController());
  final count = 0.obs;
  final showSummary = false.obs;
  final needSwitch = false.obs;
  late int stations;

  void resetAll() {
    controller.startStation.value = '';
    controller.endStation.value = '';
    count.value = 0;
    metroController.updateValues(newStations: 0, newMinutes: 0, newPrice: 0);
    showSummary.value = false;
    needSwitch.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      resetAll();
    });

    return Obx(
      () => Column(
        children: [
          Card(
            elevation: 4,
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
                    label: 'Start Station',
                    selectedValue: controller.startStation,
                    options: controller.stationNames,
                    onChanged: (value) {
                      controller.startStation.value = value;
                      count.value = 0;
                      showSummary.value = false;
                      metroController.updateValues(
                        newStations: 0,
                        newMinutes: 0,
                        newPrice: 0,
                      );

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
                    label: 'End Station',
                    selectedValue: controller.endStation,
                    options: controller.stationNames,
                    onChanged: (value) {
                      controller.endStation.value = value;
                      count.value = 0;
                      showSummary.value = false;
                      metroController.updateValues(
                        newStations: 0,
                        newMinutes: 0,
                        newPrice: 0,
                      );

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
                        color: const Color(0xFF670D2F),
                        width: 2,
                      ),
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
                            'Number Of Individuals',
                            style: TextStyle(
                              color: const Color(0xFF670D2F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () => count.value++,
                            icon: const Icon(Icons.add),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            '${count.value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              if (count.value > 0) count.value--;
                            },
                            icon: const Icon(Icons.remove),
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
                          Get.snackbar("خطأ", "اختر محطتين صحيحتين");
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
                      child: const Text('Count'),
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
                          text: '${metroController.minutes.value} دقيقة',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.train,
                          text: '${metroController.stations.value} محطات',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      // Expanded(
                      //   child: InfoCard(
                      //     icon: Icons.money,
                      //     text: 'المبلغ: ${metroController.price.value} جنيه',
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xff670D2F), width: 2),
                    ),
                    child: Text(
                      'المبلغ: ${metroController.price.value} جنيه',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  if (needSwitch.value)
                    Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xff670D2F), width: 2),
                      ),
                      child: Text(
                        '⚠️ المحطتين مش على نفس الخط.\nيجب التبديل عند محطة: ${controller.getTransferStation(controller.startStation.value, controller.endStation.value)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                        textAlign: TextAlign.center,
                      ),
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

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey[800], size: 20),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
