import 'package:get/get.dart';

class Metro extends GetxController {
  var stations = 0.obs;
  var minutes = 0.obs;
  var price = 0.0.obs;

  void updateValues({
    required int newStations,
    required int newMinutes,
    required double newPrice,
  }) {
    stations.value = newStations;
    minutes.value = newMinutes;
    price.value = newPrice;
  }
}
