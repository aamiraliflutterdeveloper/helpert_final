import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/custom_dropdown.dart';
import 'package:helpert_app/constants/text_styles.dart';

class FormRow extends StatefulWidget {
  const FormRow(
      {Key? key,
      this.expertiseValue,
      required this.items,
      required this.onChanged,
      required this.hintText,
      required this.fieldTitle})
      : super(key: key);
  final String? expertiseValue;
  final List<String> items;
  final Function(String?) onChanged;
  final String hintText;
  final String fieldTitle;
  @override
  State<FormRow> createState() => _FormRowState();
}

class _FormRowState extends State<FormRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 3,
            child: Text(
              widget.fieldTitle,
              style: TextStyles.semiBoldTextStyle(fontSize: 14),
            )),
        Flexible(
            flex: 6,
            child: CustomDropdown(
                hintText: widget.hintText,
                value: widget.expertiseValue,
                menuList: widget.items,
                onChanged: widget.onChanged)),
      ],
    );
  }
}
