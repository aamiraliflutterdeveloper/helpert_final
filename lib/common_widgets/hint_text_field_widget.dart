import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class HintTextFieldWidget extends StatelessWidget {
  const HintTextFieldWidget(
      {Key? key,
      required this.hintText,
      this.keyboardType,
      this.isMaxLines = false,
      required this.controller,
      this.borderRadius = 8,
      this.onChanged})
      : super(key: key);
  final String hintText;
  final TextInputType? keyboardType;
  final bool isMaxLines;
  final double borderRadius;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: isMaxLines == true ? 8 : 1,
      keyboardType: keyboardType,
      // controller: widget.controller,
      style:
          TextStyles.regularTextStyle(fontSize: 14, textColor: AppColors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.snow,
        contentPadding:
            const EdgeInsets.only(left: 10, right: 4, top: 20, bottom: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none),
        hintText: hintText,
        labelStyle: TextStyles.regularTextStyle(
            fontSize: 14, textColor: AppColors.moon),
      ),
    );
  }
}
