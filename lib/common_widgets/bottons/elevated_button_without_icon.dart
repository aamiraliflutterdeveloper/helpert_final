import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class ElevatedButtonWithoutIcon extends StatelessWidget {
  const ElevatedButtonWithoutIcon(
      {Key? key,
      this.fontSize = 15,
      required this.text,
      required this.onPressed,
      this.textColor = AppColors.pureWhite,
      this.primaryColor = AppColors.acmeBlue,
      this.borderColor = AppColors.acmeBlue,
      this.height = 50, this.borderRadius = 8})
      : super(key: key);
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  final Color textColor;
  final Color primaryColor;
  final Color borderColor;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0, backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.semiBoldTextStyle(
              fontSize: fontSize, textColor: textColor),
        ),
      ),
    );
  }
}
