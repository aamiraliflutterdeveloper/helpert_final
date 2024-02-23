import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';

class TransparentRoundedWidget extends StatelessWidget {
  const TransparentRoundedWidget(
      {Key? key,
      required this.child,
      required this.onTap,
      this.horizontalPadding = 16,
      this.verticalPadding = 10})
      : super(key: key);
  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
            color: AppColors.nickel.withOpacity(.8),
            borderRadius: BorderRadius.circular(8)),
        child: child,
      ),
    );
  }
}
