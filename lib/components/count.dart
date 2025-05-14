import 'package:flutter/material.dart';

class TicketDataWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TicketDataWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 6),
          Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }
}
