import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownmenu extends StatelessWidget {
  final String label;
  final RxString selectedValue;
  final List<String> options;
  final Function(String)? onChanged;

  const CustomDropdownmenu({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF670D2F),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF670D2F), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF670D2F), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF670D2F), width: 2.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        value: selectedValue.value.isEmpty ? null : selectedValue.value,
        items:
            options.map((station) {
              return DropdownMenuItem<String>(
                value: station,
                child: Text(
                  station,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              );
            }).toList(),
        onChanged: (String? value) {
          if (value != null && value != selectedValue.value) {
            selectedValue.value = value;
            onChanged?.call(value);
          }
        },
        borderRadius: BorderRadius.circular(12),
        elevation: 4,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Color(0xFF670D2F),
          size: 32,
        ),
        isExpanded: true,
        dropdownColor: Colors.white,
        menuMaxHeight: 300,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        selectedItemBuilder: (BuildContext context) {
          return options.map((String value) {
            return Text(
              value,
              style: const TextStyle(
                color: Color(0xFF670D2F),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
