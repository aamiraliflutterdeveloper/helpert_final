import 'package:flutter/material.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';

class CancelPublishTopBar extends StatelessWidget {
  const CancelPublishTopBar({
    this.onTap,
    Key? key,
  }) : super(key: key);
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              NavRouter.pop(context);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
              child: Text(
                "Cancel",
                style: TextStyles.regularTextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              "Publish",
              style: TextStyles.regularTextStyle(
                textColor: AppColors.moon,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
