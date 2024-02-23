import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';

import '../../../../../../constants/text_styles.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1.2, color: AppColors.silver)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("or You want to",
              style: TextStyles.regularTextStyle(
                  textColor: AppColors.moon, fontSize: 12)),
        ),
        Expanded(child: Divider(thickness: 1.2, color: AppColors.silver)),
      ],
    );
  }
}
