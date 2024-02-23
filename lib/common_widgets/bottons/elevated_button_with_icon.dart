import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helpert_app/constants/app_colors.dart';

class ElevatedButtonWithIcon extends StatelessWidget {
  const ElevatedButtonWithIcon(
      {Key? key,
      required this.text,
      this.isIconAvailable = false,
      required this.onPrimaryColor,
      required this.primaryColor,
      required this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = AppColors.acmeBlue,
      this.borderRadius = 12,
      this.height = 55,
      this.fontSize = 15,
      this.prefixHeight = 15})
      : super(key: key);
  final String? prefixIcon;
  final String? suffixIcon;
  final String text;
  final bool isIconAvailable;
  final Color onPrimaryColor;
  final Color primaryColor;
  final VoidCallback onTap;
  final Color borderColor;
  final double borderRadius;
  final double height;
  final double prefixHeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: onPrimaryColor,
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                  width: 1.0,
                  color: borderColor,
                )),
            elevation: 0),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: prefixIcon != null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            prefixIcon != null
                ? SvgPicture.asset(
                    prefixIcon!,
                    color: text == 'Follow' || text == 'UnFollow'
                        ? AppColors.acmeBlue
                        : AppColors.pureWhite,
                    height: prefixHeight,
                  )
                : const SizedBox.shrink(),
            prefixIcon != null
                ? const SizedBox(
                    width: 10,
                  )
                : const SizedBox(),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  fontSize: fontSize),
            ),
            // const Spacer(),
            suffixIcon != null
                ? SvgPicture.asset(suffixIcon!)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class ElevatedButtonWithIconSecond extends StatelessWidget {
  const ElevatedButtonWithIconSecond(
      {Key? key,
      required this.text,
      this.isIconAvailable = false,
      required this.onPrimaryColor,
      required this.primaryColor,
      required this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = AppColors.acmeBlue,
      this.borderRadius = 12,
      this.prefixHeight = 15})
      : super(key: key);
  final String? prefixIcon;
  final String? suffixIcon;
  final String text;
  final bool isIconAvailable;
  final Color onPrimaryColor;
  final Color primaryColor;
  final VoidCallback onTap;
  final Color borderColor;
  final double borderRadius;
  final double prefixHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: onPrimaryColor, backgroundColor: primaryColor, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                  width: 1.0,
                  color: borderColor,
                )),
            elevation: 0),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 16),
            ),
            suffixIcon != null ? SizedBox(width: 50) : SizedBox.shrink(),
            // const Spacer(),
            suffixIcon != null
                ? SvgPicture.asset(suffixIcon!)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
