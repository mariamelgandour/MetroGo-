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
    return Obx(() {
      return GestureDetector(
        onTap: () {
          showSearchableDialog(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF670D2F), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          child: Text(
            selectedValue.value.isEmpty ? 'اختر محطة' : selectedValue.value,
            style: TextStyle(
              color: selectedValue.value.isEmpty ? Colors.grey : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      );
    });
  }

  void showSearchableDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    RxList<String> filteredOptions = RxList<String>(options);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('اختر محطة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'اكتب للبحث...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  filteredOptions.value = options
                      .where((option) =>
                          option.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                },
              ),
              const SizedBox(height: 12),
              Obx(() {
                return SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: filteredOptions.length,
                    itemBuilder: (context, index) {
                      final item = filteredOptions[index];
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          selectedValue.value = item;
                          onChanged?.call(item);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
