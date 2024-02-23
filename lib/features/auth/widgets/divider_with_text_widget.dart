import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class DividerWithTextWidget extends StatelessWidget {
  final String text;
  const DividerWithTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.silver,
            height: 1,
            thickness: 1,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          text,
          style: TextStyles.regularTextStyle(
              fontSize: 12, textColor: AppColors.moon),
        ),
        const SizedBox(
          width: 12,
        ),
        const Expanded(
          child: Divider(
            color: AppColors.silver,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
