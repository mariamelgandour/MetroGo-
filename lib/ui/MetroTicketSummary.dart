import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/MetroController.dart';

class MetroTicketSummary extends StatelessWidget {
  MetroTicketSummary({super.key});

  final MetroController controller = Get.find<MetroController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // عدد المحطات والدقايق
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // عدد المحطات
            Column(
              children: [
                Icon(Icons.train, color: Colors.grey[800]),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    '${controller.stations.value}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text('محطات', style: TextStyle(color: Colors.grey)),
              ],
            ),

            // عدد الدقايق
            Column(
              children: [
                Icon(Icons.access_time, color: Colors.grey[800]),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    '${controller.minutes.value}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text('دقيقه', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
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
