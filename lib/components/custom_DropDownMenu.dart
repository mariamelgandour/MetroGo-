import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownmenu extends StatelessWidget {
  final String label;
  final RxString selectedValue;
  final List<String> options;

  const CustomDropdownmenu({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF670D2F)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF670D2F), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF670D2F), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF670D2F), width: 2.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        value: selectedValue.value.isEmpty ? null : selectedValue.value,
        items:
            options.map((station) {
              return DropdownMenuItem(value: station, child: Text(station));
            }).toList(),
        onChanged: (value) {
          if (value != null) {
            selectedValue.value = value;
          }
        },
      ),
    );
  }
}
