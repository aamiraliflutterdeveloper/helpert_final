import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String? errorMessage;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final Function(String? value)? onSaved;
  final Function(String value)? onChanged;
  final int? isMaxLines;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final bool hasPadding;
  final FormFieldValidator<String>? validator;
  final bool hasSuffixIcon;
  final Widget? suffixIcon;
  final GestureTapCallback? onPressSuffixIcon;
  final bool isQuestionScreen;
  final String? hintText;
  final bool hasHintText;

  const CustomTextFormField({
    required this.labelText,
    this.errorMessage,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.isMaxLines,
    this.onTap,
    this.readOnly = true,
    this.hasPadding = false,
    this.validator,
    this.hasSuffixIcon = false,
    this.suffixIcon,
    this.onPressSuffixIcon,
    this.isQuestionScreen = false,
    this.hasHintText = false,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: TextFormField(
                validator: widget.validator,
                enabled: widget.readOnly,
                maxLines: widget.isMaxLines,
                textInputAction: widget.textInputAction,
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                focusNode: _focus,
                onChanged: widget.onChanged,
                onSaved: widget.onSaved,
                style: TextStyles.regularTextStyle(
                    fontSize: 14, textColor: AppColors.black),
                decoration: InputDecoration(
                  hintText: widget.hasHintText == true ? widget.hintText : null,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: widget.hasSuffixIcon == true
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: widget.onPressSuffixIcon,
                          child: widget.suffixIcon)
                      : SizedBox.shrink(),
                  alignLabelWithHint: widget.isMaxLines != null,
                  border: InputBorder.none,
                  labelText:
                      widget.hasHintText == true ? null : widget.labelText,
                  labelStyle: TextStyles.regularTextStyle(
                      fontSize: 14, textColor: AppColors.moon),
                ),
              ),
            ),
          ),
        ),
        widget.isQuestionScreen == false
            ? Text(
                widget.errorMessage ?? '',
                style: TextStyles.regularTextStyle(
                    fontSize: 12, textColor: AppColors.failure),
              )
            : SizedBox.shrink(),
        SizedBox(
          height: widget.hasPadding ? 12 : 0,
        ),
      ],
    );
  }
}
