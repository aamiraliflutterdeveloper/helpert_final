import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/text_styles.dart';

import '../fetch_svg.dart';

class DateTextFormField extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? errorMessage;
  const DateTextFormField({
    this.errorMessage,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<DateTextFormField> createState() => _DateTextFormFieldState();
}

class _DateTextFormFieldState extends State<DateTextFormField> {
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
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: _focus.hasFocus == true
                  ? AppColors.pureWhite
                  : AppColors.snow,
              border: Border.all(
                color: _focus.hasFocus == true
                    ? widget.errorMessage != null
                        ? AppColors.failure
                        : AppColors.acmeBlue
                    : widget.errorMessage != null
                        ? AppColors.failure
                        : AppColors.snow,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 17),
                child: TextFormField(
                  enabled: false,
                  keyboardType: widget.keyboardType,
                  controller: widget.controller,
                  focusNode: _focus,
                  style: TextStyles.regularTextStyle(
                      fontSize: 14, textColor: AppColors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 14),
                      child: SvgImage(
                        path: ic_calender,
                        color: widget.controller.text.isNotEmpty
                            ? AppColors.acmeBlue
                            : AppColors.moon,
                      ),
                    ),
                    border: InputBorder.none,
                    labelText: widget.labelText,
                    labelStyle: TextStyles.regularTextStyle(
                        fontSize: 14, textColor: AppColors.moon),
                  ),
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
