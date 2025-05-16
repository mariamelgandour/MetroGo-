import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../colorTheme.dart';
import '../components/custom_DropDownMenu.dart';
import '../controllers/MetroController.dart';
import '../controllers/StationsController.dart';
import '../controllers/themeController.dart';
import 'MetroTicketSummary.dart';

import '../data/metro_lines.dart';

class HomePage extends StatelessWidget {
  final StationController stationController = Get.put(StationController());
  final MetroController metroController = Get.put(MetroController());
  final ThemeController themeController = Get.find<ThemeController>();

  final count = 0.obs;
  final showSummary = false.obs;
  final needSwitch = false.obs;
  final enabled = false.obs;
  final nearestStationName = ''.obs;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    count.value = 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            'We Wish You an easy Trip'.tr,
            style: TextStyle(
              color:
                  themeController.isDarkMode.value
                      ? Colors.white
                      : AppThemes.lightMainColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          backgroundColor:
              themeController.isDarkMode.value
                  ? AppThemes.darkMainColor
                  : Colors.white,
          iconTheme: IconThemeData(
            color:
                themeController.isDarkMode.value
                    ? Colors.white
                    : AppThemes.lightMainColor,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 85,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          themeController.isDarkMode.value
                              ? AppThemes.darkMainColor
                              : Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        isDark
                            ? 'assets/images/logoDark.jpg'
                            : 'assets/images/metrologo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'nearest_metro_station'.tr,
                      style: TextStyle(
                        color:
                            themeController.isDarkMode.value
                                ? Colors.white70
                                : AppThemes.lightMainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 270,
                          decoration: BoxDecoration(
                            color: isDark ? Color(0xff24242c) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark ? Colors.white : Color(0xFF670D2F),
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            nearestStationName.value.isEmpty
                                ? 'please_open_gps'.tr
                                : nearestStationName.value,
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF670D2F),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.gps_fixed,
                            color: isDark ? Colors.white : Color(0xFF670D2F),
                          ),
                          onPressed: () => getLocation(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomDropdownmenu(
                    label: 'start_station'.tr,
                    text: 'select_station'.tr,
                    hintMassage: false,
                    selectedValue: stationController.startStation,
                    options: stationController.stationNames,
                    onChanged: (value) {
                      stationController.startStation.value = value;
                      count.value = 0;
                      showSummary.value = false;
                      metroController.updateValues(
                        newStations: 0,
                        newMinutes: 0,
                        newPrice: 0,
                      );
                      if (stationController.endStation.value.isNotEmpty) {
                        needSwitch.value =
                            stationController.getLineOfStation(value) !=
                            stationController.getLineOfStation(
                              stationController.endStation.value,
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 6),
                  CustomDropdownmenu(
                    label: 'end_station'.tr,
                    text: 'select_station'.tr,
                    hintMassage: false,
                    selectedValue: stationController.endStation,
                    options: stationController.stationNames,
                    onChanged: (value) {
                      stationController.endStation.value = value;
                      count.value = 0;
                      showSummary.value = false;
                      metroController.updateValues(
                        newStations: 0,
                        newMinutes: 0,
                        newPrice: 0,
                      );
                      if (stationController.startStation.value.isNotEmpty) {
                        needSwitch.value =
                            stationController.getLineOfStation(value) !=
                            stationController.getLineOfStation(
                              stationController.startStation.value,
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 290,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        elevation: 5,
                        backgroundColor:
                            themeController.isDarkMode.value
                                ? AppThemes.darkSecondColor
                                : AppThemes.lightMainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final start = stationController.startStation.value;
                        final end = stationController.endStation.value;
                        final individuals = count.value;

                        if (start == '' || end == '') {
                          Get.snackbar("error".tr, "select_both_stations".tr);
                          return;
                        }

                        final sameLine =
                            stationController.getLineOfStation(start) ==
                            stationController.getLineOfStation(end);
                        needSwitch.value = !sameLine;

                        final stations = metroController
                            .calculateStationsBetween(start, end);
                        final minutes = metroController.calculateTime(stations);
                        final totalPrice = metroController.calculateTotalPrice(
                          stations,
                          individuals,
                        );

                        metroController.updateValues(
                          newStations: stations,
                          newMinutes: minutes,
                          newPrice: totalPrice,
                        );

                        showSummary.value = true;

                        Get.to(
                          () => MetroTicketSummary(start: start, end: end),
                        );
                      },
                      child: Text('get_details'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor:
            themeController.isDarkMode.value
                ? AppThemes.darkMainColor
                : Colors.white,
      ),
    );
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('error'.tr, 'location_services_disabled'.tr);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('error'.tr, 'location_permissions_denied'.tr);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('error'.tr, 'location_permissions_permanently_denied'.tr);
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    final nearest = getNearestStation(position.latitude, position.longitude);
    nearestStationName.value = nearest;
  }

  String getNearestStation(double userLat, double userLng) {
    double minDistance = double.infinity;
    String nearestStationName = '';

    List<Map<String, dynamic>> allStations = [
      ...MetroLines.line1,
      ...MetroLines.line2,
      ...MetroLines.line3,
    ];

    final uniqueStations = <String, Map<String, dynamic>>{};
    for (var station in allStations) {
      uniqueStations[station['name']] = station;
    }

    for (var station in uniqueStations.values) {
      final distance = Geolocator.distanceBetween(
        userLat,
        userLng,
        station['lat'],
        station['lng'],
      );
      if (distance < minDistance) {
        minDistance = distance;
        nearestStationName = station['name'];
      }
    }

    return nearestStationName;
  }
}
