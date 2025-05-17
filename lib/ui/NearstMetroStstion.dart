import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/themeController.dart';
import '../data/metro_lines.dart';
import '../colorTheme.dart';

class NearestStationMap extends StatelessWidget {
  final double userLat;
  final double userLng;
  final String nearestStationName;

  NearestStationMap({
    required this.userLat,
    required this.userLng,
    required this.nearestStationName,
    Key? key,
  }) : super(key: key);

  final ThemeController themeController = Get.find<ThemeController>();

  Map<String, dynamic>? getStationByName(String name) {
    final allStations = [
      ...MetroLines.line1,
      ...MetroLines.line2,
      ...MetroLines.line3,
    ];
    return allStations.firstWhereOrNull((station) => station['name'] == name);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDarkMode.value;
    final station = getStationByName(nearestStationName);

    final LatLng defaultEgyptLocation = LatLng(30.0444, 31.2357);

    final bool isValidUserLocation =
        userLat > 20 && userLat < 32 && userLng > 24 && userLng < 36;

    if (!isValidUserLocation) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'use_default_location'.tr,
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 3),
            backgroundColor:
                isDark
                    ? AppThemes.darkMainColor.withOpacity(0.9)
                    : AppThemes.lightMainColor.withOpacity(0.9),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        );
      });
    }

    final LatLng centerLocation =
        isValidUserLocation ? LatLng(userLat, userLng) : defaultEgyptLocation;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'nearest_metro_station'.tr,
          style: TextStyle(
            color: isDark ? Colors.white : AppThemes.lightMainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDark ? AppThemes.darkMainColor : Colors.white,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppThemes.lightMainColor,
        ),
      ),
      body:
          station == null
              ? Center(child: Text('station_not_found'.tr))
              : FlutterMap(
                options: MapOptions(
                  initialCenter: centerLocation,
                  initialZoom: 14.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    userAgentPackageName: 'com.example.google_map',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: centerLocation,
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person_pin_circle,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                      Marker(
                        point: LatLng(
                          station['lat'] as double,
                          station['lng'] as double,
                        ),
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.train,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      backgroundColor:
          isDark ? AppThemes.darkMainColor : AppThemes.lightSecondColor,
    );
  }
}
