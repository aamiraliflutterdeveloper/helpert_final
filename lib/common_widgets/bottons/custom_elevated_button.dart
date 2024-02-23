import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final bool disable;
  final Color color;
  final Color textColor;
  final Color disabledColor;
  final VoidCallback onTap;
  final EdgeInsets padding;
  const CustomElevatedButton({
    required this.title,
    required this.onTap,
    this.disable = false,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.color = AppColors.acmeBlue,
    this.textColor = AppColors.pureWhite,
    this.disabledColor = AppColors.silver,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? () {} : onTap,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: disable ? disabledColor : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: padding),
      child: Text(title,
          style: TextStyles.semiBoldTextStyle(
              textColor: disable ? AppColors.moon : textColor)),
    );
  }
}
