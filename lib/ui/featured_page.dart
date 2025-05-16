import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/ui/MetroLines.dart';
import '../components/custom_TextButton.dart';
import 'TicketPrice.dart';

class FeaturePage extends StatelessWidget {
  final enabled = false.obs;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: isDark ? Color(0xff24242c) : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(screenWidth * 0.05),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF670D2F), width: 2),
                color: isDark ? Color(0xff24242c) : Colors.white,
              ),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomToggleButton(
                      text: 'metro_lines'.tr,
                      isSelected: enabled.value,
                      onPressed: () => enabled.value = true,
                      isDark: isDark,
                    ),
                    VerticalDivider(
                      width: 20,
                      thickness: 1,
                      color: const Color(0xFF670D2F),
                      indent: 8,
                      endIndent: 8,
                    ),
                    CustomToggleButton(
                      text: 'ticket_price'.tr,
                      isSelected: !enabled.value,
                      onPressed: () => enabled.value = false,
                      isDark: isDark,
                    ),
                  ],
                );
              }),
            ),
            Expanded(
              child: Obx(() {
                return enabled.value
                    ? Metrolines(imagePath: 'assets/images/metromap.png')
                    : TicketPrice();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
