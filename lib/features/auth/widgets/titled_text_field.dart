import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/hint_text_field_widget.dart';
import 'package:helpert_app/constants/text_styles.dart';

class TitledTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  const TitledTextField(
      {Key? key, required this.title, required this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 3,
            child: Text(
              title,
              style: TextStyles.semiBoldTextStyle(fontSize: 14),
            )),
        Flexible(
            flex: 6,
            child: HintTextFieldWidget(
              controller: controller!,
              keyboardType: TextInputType.number,
              hintText: hintText,
            )),
      ],
    );
  }
}
