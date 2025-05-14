import 'package:get/get.dart';
import 'package:google_map/controllers/video_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: VideoPlayer(controller.videoController),
              width: 250,
              height: 250,
            ),

            Text(
              'METRO GO',
              style: TextStyle(
                fontFamily: 'Elephant',
                color: Color(0xFFCE5A5A),
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
