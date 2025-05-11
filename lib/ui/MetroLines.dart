import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/custom_DropDownMenu.dart';
import '../controllers/StationsController.dart';

class Metrolines extends StatelessWidget {
  final String imagePath;
  final controller = Get.put(StationController());

  Metrolines({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
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
                  label: 'Metro Lines',
                  selectedValue: controller.startStation,
                  options: controller.stationNames,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
