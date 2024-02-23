import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/text_styles.dart';

class MoreTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const MoreTileWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(title, style: TextStyles.mediumTextStyle(fontSize: 15)),
      subtitle: Text(subTitle,
          style: TextStyles.mediumTextStyle(
              textColor: AppColors.acmeBlue, fontSize: 13)),
    );
  }
}
