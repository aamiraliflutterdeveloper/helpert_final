import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class SearchTextFormField extends StatelessWidget {
  final String hintText;
  final bool enabled;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final VoidCallback? onTap;
  final TextEditingController controller;
  const SearchTextFormField({
    Key? key,
    required this.hintText,
    this.enabled = true,
    this.onChanged,
    this.onSaved,
    this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.acmeBlue,
        onTap: onTap,
        onSaved: onSaved,
        onChanged: onChanged,
        decoration: InputDecoration(
          enabled: enabled,
          filled: true,
          fillColor: AppColors.snow,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.moon,
          ),
          hintText: hintText,
          hintStyle: TextStyles.regularTextStyle(
              textColor: AppColors.nickel, fontSize: 14),
          contentPadding: const EdgeInsets.all(16),
          border: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
