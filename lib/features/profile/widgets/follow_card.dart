import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/text_styles.dart';

class FollowCard extends StatelessWidget {
  final String total;
  final String title;

  const FollowCard({Key? key, required this.title, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: TextStyles.semiBoldTextStyle(fontSize: 14)),
        const SizedBox(width: 5),
        Text(total,
            style: TextStyles.regularTextStyle(
                fontSize: 14, textColor: AppColors.moon)),
      ],
    );
  }
}
