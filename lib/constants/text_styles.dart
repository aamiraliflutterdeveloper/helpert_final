import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/consts.dart';

class TextStyles {
  static TextStyle regularTextStyle(
      {Color textColor = AppColors.black,
      double fontSize = 16,
      double height = 1.35,
      String fontFamily = poppinsFamily}) {
    return TextStyle(
        color: textColor,
        fontSize: fontSize,
        height: height,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily);
  }

  static TextStyle mediumTextStyle(
      {Color textColor = AppColors.black,
      double fontSize = 16,
      String fontFamily = poppinsFamily}) {
    return TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily);
  }

  static TextStyle semiBoldTextStyle(
      {Color textColor = AppColors.black,
      double fontSize = 16,
      String fontFamily = poppinsFamily}) {
    return TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily);
  }

  static TextStyle boldTextStyle(
      {Color textColor = AppColors.black,
      double fontSize = 16,
      String fontFamily = poppinsFamily}) {
    return TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily);
  }
}
