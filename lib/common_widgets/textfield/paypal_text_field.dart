import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class PaypalTextFiled extends StatefulWidget {
  final String labelText;
  final String? errorMessage;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String? value)? onSaved;
  final Function(String value)? onChanged;
  final int? isMaxLines;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final GestureTapCallback? onPressed;
  final bool obscureText;

  const PaypalTextFiled({
    required this.labelText,
    this.errorMessage,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.onSaved,
    this.onChanged,
    this.isMaxLines,
    required this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onPressed,
    this.readOnly = true,
    required this.obscureText,
    Key? key,
  }) : super(key: key);

  @override
  State<PaypalTextFiled> createState() => _PaypalTextFiledState();
}

class _PaypalTextFiledState extends State<PaypalTextFiled> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: _focus.hasFocus == true ? AppColors.snow : AppColors.snow,
              border: Border.all(
                color: _focus.hasFocus == true
                    ? widget.errorMessage != null
                        ? AppColors.failure
                        : AppColors.snow
                    : widget.errorMessage != null
                        ? AppColors.failure
                        : AppColors.snow,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: TextFormField(
                obscureText: widget.obscureText,
                enabled: widget.readOnly,
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                focusNode: _focus,
                onChanged: widget.onChanged,
                onSaved: widget.onSaved,
                style: TextStyles.regularTextStyle(
                    fontSize: 14, textColor: AppColors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.prefixIcon,
                    color: AppColors.moon,
                  ),
                  suffixIcon: widget.suffixIcon != null
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: widget.onPressed,
                          child: Icon(
                            widget.suffixIcon,
                            color: AppColors.moon,
                          ))
                      : const SizedBox.shrink(),
                  alignLabelWithHint: widget.isMaxLines != null,
                  border: InputBorder.none,
                  labelText: widget.labelText,
                  labelStyle: TextStyles.regularTextStyle(
                      fontSize: 14, textColor: AppColors.moon),
                ),
              ),
            ),
          ),
        ),
        Text(
          widget.errorMessage ?? '',
          style: TextStyles.regularTextStyle(
              fontSize: 12, textColor: AppColors.failure),
        ),
      ],
    );
  }
}
