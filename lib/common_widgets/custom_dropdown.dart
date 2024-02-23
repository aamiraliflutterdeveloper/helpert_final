import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hintText;
  final List<String> menuList;
  final Function(String?) onChanged;
  const CustomDropdown(
      {Key? key,
      this.value,
      required this.menuList,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.snow, borderRadius: BorderRadius.circular(5)),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(hintText),
        ),
        dropdownColor: AppColors.snow,
        iconSize: 0.0,
        isExpanded: true,
        value: value,
        items: menuList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(items),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
