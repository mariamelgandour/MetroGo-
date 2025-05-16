import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownmenu extends StatelessWidget {
  final String label;
  final RxString selectedValue;
  final List<String> options;
  final Function(String)? onChanged;
  final bool hintMassage;
  final String? hintText;
  final String text;

  const CustomDropdownmenu({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    this.onChanged,
    required this.hintMassage,
    this.hintText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      return GestureDetector(
        onTap: () {
          showSearchableDialog(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: isDark ? Colors.white : Color(0xFF670D2F),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white : Color(0xFF670D2F),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),

              borderSide: BorderSide(
                color: isDark ? Colors.white : Color(0xFF670D2F),
                width: 2,
              ),
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          child: Text(
            selectedValue.value.isEmpty ? '${text}' : selectedValue.value,
            style: TextStyle(
              color: isDark ? Colors.white : Color(0xFF670D2F),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      );
    });
  }

  void showSearchableDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    TextEditingController searchController = TextEditingController();
    RxList<String> filteredOptions = RxList<String>(options);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? Color(0xff393E46) : Colors.white,
          title: Text(
            '${text}',
            style: TextStyle(
              color: isDark ? Colors.white : Color(0xFF670D2F),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: isDark ? Colors.white : Color(0xffA53860),

                autocorrect: true,
                enabled: true,
                mouseCursor: MouseCursor.defer,
                enableSuggestions: true,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark ? Colors.white : Color(0xFF670D2F),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark ? Colors.white : Color(0xFF670D2F),
                    ),
                  ),
                ),
                onChanged: (value) {
                  filteredOptions.value =
                      options
                          .where(
                            (option) => option.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                          )
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
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              item,
                              style: TextStyle(
                                color:
                                    isDark ? Colors.white : Color(0xFF670D2F),
                              ),
                            ),
                            onTap: () {
                              selectedValue.value = item;
                              onChanged?.call(item);
                              Navigator.of(context).pop();
                            },
                          ),
                          Divider(
                            color: isDark ? Colors.white : Color(0xFF670D2F),
                            height: 3,
                          ),
                        ],
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
