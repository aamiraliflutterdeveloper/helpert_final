import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/hint_text_field_widget.dart';
import 'package:helpert_app/constants/app_colors.dart';

class HiddenWidget extends StatelessWidget {
  final String hintText;
  final bool visibility;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  const HiddenWidget(
      {Key? key,
      required this.hintText,
      required this.visibility,
      required this.controller,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Container(
        color: AppColors.snow,
        child: HintTextFieldWidget(
          onChanged: onChanged,
          controller: controller,
          keyboardType: TextInputType.text,
          hintText: hintText,
        ),
      ),
    );
  }
}
