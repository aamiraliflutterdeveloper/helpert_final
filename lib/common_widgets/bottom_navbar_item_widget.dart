import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

import 'fetch_svg.dart';

class BottomNavBarItemWidget extends StatelessWidget {
  const BottomNavBarItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.enabled,
    this.alert = false,
  }) : super(key: key);

  final String icon;
  final String title;
  final bool enabled;
  final bool alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 4,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SvgImage(
                path: icon,
                color: enabled ? AppColors.acmeBlue : AppColors.moon,
              ),
              if (alert)
                Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppColors.failure, shape: BoxShape.circle),
                    )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            maxLines: 1,
            style: enabled
                ? TextStyles.semiBoldTextStyle(
                    fontSize: 10, textColor: AppColors.black)
                : TextStyles.mediumTextStyle(
                    fontSize: 10, textColor: AppColors.moon),
          )
        ],
      ),
    );
  }
}
