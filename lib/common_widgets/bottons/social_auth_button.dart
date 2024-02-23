import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helpert_app/constants/app_colors.dart';

class SocialAuthButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double innerPadding;

  const SocialAuthButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.height = 60,
    this.width = 60,
    this.innerPadding = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(innerPadding),
        child: SvgPicture.asset(icon),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.silver, width: 1),
        ),
      ),
    );
  }
}
