import 'package:flutter/material.dart';

class DetailsContainer extends StatelessWidget {
  final String text;
  final double height;
  final double width;

  const DetailsContainer({
    required this.text,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? Color(0xff393E46) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white : Color(0xFF670D2F),
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isDark ? Colors.white : Color(0xFF670D2F),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
