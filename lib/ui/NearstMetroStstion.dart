import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../data/metro_lines.dart';

class NearestStationMap extends StatelessWidget {
  final double userLat;
  final double userLng;
  final String nearestStationName;

  NearestStationMap({
    required this.userLat,
    required this.userLng,
    required this.nearestStationName,
  });

  @override
  Widget build(BuildContext context) {
    final nearestStation = [
      ...MetroLines.line1,
      ...MetroLines.line2,
      ...MetroLines.line3,
    ].firstWhere(
      (station) => station['name'] == nearestStationName,
      orElse: () => {'name': 'غير معروف', 'lat': userLat, 'lng': userLng},
    );

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(userLat, userLng),
          initialZoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.google_map',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(userLat, userLng),
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
                  nearestStation['lat'] as double,
                  nearestStation['lng'] as double,
                ),
                width: 60,
                height: 60,
                alignment: Alignment.center,
                child: const Icon(Icons.train, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
