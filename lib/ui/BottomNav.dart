import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_map/ui/settings_page.dart';

import 'Home_Page.dart';
import 'featured_page.dart';
import '../controllers/navigation_controller.dart';

class BottomNavBar extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          index: controller.selectedIndex.value,
          items: [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined, color: Colors.white),
              label: 'Home',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.star_outline, color: Colors.white),
              label: 'Feature',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.settings_outlined, color: Colors.white),
              label: 'Settings',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ],
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          color: Color(0xFF670D2F),
          backgroundColor: Colors.white,
        );
      }),
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return HomePage();
          case 1:
            return FeaturePage();
          case 2:
            return SettingsPage();
          default:
            return HomePage();
        }
      }),
    );
  }
}
