import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/custom_DropDownMenu.dart';
import '../controllers/MetroController.dart';
import '../controllers/StationsController.dart';

class TicketPrice extends StatelessWidget {
  final controller = Get.put(StationController());
  final metroController = Get.put(MetroController()); // ✅ التعديل هنا
  final count = 0.obs;
  final showSummary = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
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
                    label: 'Start Station',
                    selectedValue: controller.startStation,
                    options: controller.stationNames,
                  ),
                  SizedBox(height: 20),
                  CustomDropdownmenu(
                    label: 'End Station',
                    selectedValue: controller.endStation,
                    options: controller.stationNames,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF670D2F), width: 2),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            'Number Of Individuals',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF670D2F),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            count.value++;
                          },
                          icon: const Icon(Icons.add),
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          '${count.value}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            if (count.value > 0) count.value--;
                          },
                          icon: const Icon(Icons.remove),
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF670D2F),
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFF670D2F), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        final start = controller.startStation.value;
                        final end = controller.endStation.value;
                        final individuals = count.value;

                        int stations = metroController.calculateStationsBetween(
                          start,
                          end,
                        );

                        if (stations == -1) {
                          Get.snackbar(
                            "Error",
                            "Stations are not on the same line",
                          );
                          return;
                        }

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
                      child: Text('Count'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (showSummary.value) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey[800]),
                          SizedBox(width: 8),
                          Text(
                            '${metroController.minutes.value} دقيقة',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.train, color: Colors.grey[800]),
                          SizedBox(width: 8),
                          Text(
                            '${metroController.stations.value} محطات',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF670D2F), width: 2),
              ),
              child: Center(
                child: Text(
                  'المبلغ: ${metroController.price.value} جنيه',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
