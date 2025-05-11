import 'package:get/get.dart';
import 'package:google_map/ui/BottomNav.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoController;
  var isInitialized = false.obs;
  var isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    videoController = VideoPlayerController.asset('assets/videos/metro.mp4')
      ..initialize().then((_) {
        isInitialized.value = true;
      });

    videoController.play();
    Future.delayed(Duration(seconds: 5), () {
      if (Get.currentRoute != '/main') {
        Get.off(BottomNavBar());
      }
    });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
