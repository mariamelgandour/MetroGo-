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

  void resetAll() {
    controller.startStation.value = '';
    controller.endStation.value = '';
    count.value = 0;
    metroController.updateValues(newStations: 0, newMinutes: 0, newPrice: 0);
    showSummary.value = false;
  }

  @override
  Widget build(BuildContext context) {
    // تصفير عند أول دخول
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resetAll();
    });

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
                    onChanged: (value) {
                      controller.startStation.value = value;
                      count.value = 0;
                      metroController.updateValues(
                        newStations: 0,
                        newMinutes: 0,
                        newPrice: 0,
                      );
                      showSummary.value = false;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomDropdownmenu(
                    label: 'End Station',
                    selectedValue: controller.endStation,
                    options: controller.stationNames,
                    onChanged: (value) {
                      controller.endStation.value = value;
                      count.value = 0;
                      metroController.updateValues(
                        newStations: 0,
                        newMinutes: 0,
                        newPrice: 0,
                      );
                      showSummary.value = false;
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    height:
                        MediaQuery.of(context).size.height *
                        0.06, // ارتفاع 6% من الشاشة
                    width:
                        MediaQuery.of(context).size.width *
                        0.9, // العرض 90% من الشاشة
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF670D2F),
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            'Number Of Individuals',
                            style: TextStyle(
                              color: const Color(0xFF670D2F),
                              fontSize:
                                  MediaQuery.of(context).size.width *
                                  0.035, // يعتمد على العرض
                              fontWeight: FontWeight.w500,
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
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

                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF670D2F),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        final start = controller.startStation.value;
                        final end = controller.endStation.value;
                        final individuals = count.value;

                        if (start == '' || end == '') {
                          Get.snackbar("خطأ", "اختر محطتين صحيحتين");
                          return;
                        }

                        int stations = metroController.calculateStationsBetween(
                          start,
                          end,
                        );
                        if (stations == -1) {
                          Get.snackbar("خطأ", "المحطات ليست على نفس الخط");
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

          /// 👇 النتائج
          if (showSummary.value) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      icon: Icons.access_time,
                      text: '${metroController.minutes.value} دقيقة',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.train,
                      text: '${metroController.stations.value} محطات',
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

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[800]),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
