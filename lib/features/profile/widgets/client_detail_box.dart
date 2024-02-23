import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/text_styles.dart';

class ClientDetailsBox extends StatelessWidget {
  final String total;
  final String title;

  const ClientDetailsBox({Key? key, required this.total, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            total,
            style: TextStyles.boldTextStyle(textColor: AppColors.acmeBlue),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            title,
            style: TextStyles.mediumTextStyle(fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}
