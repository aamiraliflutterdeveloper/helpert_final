import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class PasswordTextFormField extends StatefulWidget {
  final String labelText;
  final String? errorMessage;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final Function(String? value)? onSaved;
  final Function(String value)? onChanged;
  final VoidCallback? showHidePassword;
  final bool hasPadding;

  const PasswordTextFormField({
    required this.labelText,
    this.errorMessage,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.onSaved,
    this.onChanged,
    this.showHidePassword,
    this.obscureText = false,
    this.hasPadding = false,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
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
        Container(
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color:
                _focus.hasFocus == true ? AppColors.pureWhite : AppColors.snow,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 17, right: 4),
            child: TextFormField(
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              obscureText: widget.obscureText,
              focusNode: _focus,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              style: TextStyles.regularTextStyle(
                  fontSize: 14, textColor: AppColors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.showHidePassword,
                    child: Icon(
                      widget.obscureText == true
                          ? Icons.remove_red_eye_sharp
                          : Icons.visibility_off,
                      color: _focus.hasFocus == true
                          ? AppColors.acmeBlue
                          : AppColors.moon,
                    )),
                border: InputBorder.none,
                labelText: widget.labelText,
                labelStyle: TextStyles.regularTextStyle(
                    fontSize: 14, textColor: AppColors.moon),
              ),
            ),
          ),
        ),
        Text(
          widget.errorMessage ?? '',
          style: TextStyles.regularTextStyle(
              fontSize: 12, textColor: AppColors.failure),
        ),
        SizedBox(height: widget.hasPadding ? 12 : 0),
      ],
    );
  }
}
