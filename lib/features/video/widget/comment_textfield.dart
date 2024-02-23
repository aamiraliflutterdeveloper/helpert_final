import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class CommentTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final VoidCallback onIconTap;
  final VoidCallback? onTap;
  final Function(String) onChanged;
  const CommentTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.onChanged,
      this.focusNode,
      this.onTap,
      required this.onIconTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.acmeBlue,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.snow,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText,
          hintStyle: TextStyles.regularTextStyle(
              textColor: AppColors.moon, fontSize: 14),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.snow,
              ),
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.acmeBlue,
              ),
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.snow,
              ),
              borderRadius: BorderRadius.circular(30)),
          suffixIcon: IconButton(
            onPressed: onIconTap,
            icon: Icon(
              Icons.send,
              color:
                  controller.text.isEmpty ? AppColors.moon : AppColors.acmeBlue,
            ),
          )),
    );
  }
}
