import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/components/count.dart';
import '../controllers/MetroController.dart';

class MetroTicketSummary extends StatelessWidget {
  MetroTicketSummary({super.key});

  final MetroController controller = Get.find<MetroController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // عدد المحطات والدقايق باستخدام CountWidget
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TicketDataWidget(
                icon: Icons.train,
                text: '${controller.stations.value} محطات',
              ),
              TicketDataWidget(
                icon: Icons.access_time,
                text: '${controller.minutes.value} دقيقه',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // المبلغ
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'المبلغ الي هيتدفع...',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  '${controller.price.value} جنيه',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
