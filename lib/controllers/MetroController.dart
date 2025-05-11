import 'package:get/get.dart';

class MetroController extends GetxController {
  var stations = 0.obs;
  var minutes = 0.obs;
  var price = 0.obs;

  // لو حبيتِ تعملي تحديث
  void updateValues({
    required int newStations,
    required int newMinutes,
    required int newPrice,
  }) {
    stations.value = newStations;
    minutes.value = newMinutes;
    price.value = newPrice;
  }
}
