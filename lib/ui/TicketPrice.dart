import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/ui/MetroTicketSummary.dart';
import '../components/custom_DropDownMenu.dart';
import '../controllers/Metro.dart';
import '../controllers/StationsController.dart';

class TicketPrice extends StatelessWidget {
  final controller = Get.put(StationController());
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            CustomDropdownmenu(
              label: 'Number of individuals',
              selectedValue: controller.endStation,
              options: controller.stationNames,
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  final controller = Get.find<Metro>();

                  controller.updateValues(
                    newStations: 5,
                    newMinutes: 10,
                    newPrice: 7.0,
                  );

                  Get.to(() => MetroTicketSummary());
                },
                child: Text('Count'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
