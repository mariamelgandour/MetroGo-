import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/ui/MetroLines.dart';
import '../components/custom_TextButton.dart';
import 'TicketPrice.dart';

class FeaturePage extends StatelessWidget {
  final enabled = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF670D2F), width: 2),
              ),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomToggleButton(
                      text: 'Metro Lines',
                      isSelected: enabled.value,
                      onPressed: () => enabled.value = true,
                    ),
                    VerticalDivider(
                      width: 20,
                      thickness: 1,
                      color: Color(0xFF670D2F),
                      indent: 8,
                      endIndent: 8,
                    ),
                    CustomToggleButton(
                      text: 'Ticket Price',
                      isSelected: !enabled.value,
                      onPressed: () => enabled.value = false,
                    ),
                  ],
                );
              }),
            ),

            Obx(() {
              if (enabled.value) {
                return Metrolines(imagePath: 'assets/images/metromap.png');
              } else {
                return TicketPrice();
              }
            }),
          ],
        ),
      ),
    );
  }
}
