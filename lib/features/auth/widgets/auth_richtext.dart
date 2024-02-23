import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class AuthRichText extends StatelessWidget {
  final String text;
  final String coloredText;
  final VoidCallback onTap;
  const AuthRichText(
      {Key? key, required this.text, required this.coloredText, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyles.regularTextStyle(
            fontSize: 14, textColor: AppColors.moon),
        children: <TextSpan>[
          TextSpan(
            text: coloredText,
            style: TextStyles.semiBoldTextStyle(
                fontSize: 14, textColor: AppColors.acmeBlue),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
