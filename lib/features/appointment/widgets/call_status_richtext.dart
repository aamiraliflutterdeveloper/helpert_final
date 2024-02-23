import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class CallStatusRichText extends StatelessWidget {
  final String text;
  final String coloredText;
  final Color textColor;
  final VoidCallback? callback;
  const CallStatusRichText(
      {Key? key,
      required this.text,
      required this.coloredText,
      this.textColor = AppColors.acmeBlue,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyles.regularTextStyle(
            fontSize: 14, textColor: const Color(0xFF263238)),
        children: <TextSpan>[
          TextSpan(
            text: '  - ',
            style: TextStyles.regularTextStyle(
                fontSize: 14, textColor: AppColors.nickel),
            recognizer: TapGestureRecognizer()..onTap = callback,
          ),
          TextSpan(
            text: coloredText,
            style:
                TextStyles.regularTextStyle(fontSize: 14, textColor: textColor),
            recognizer: TapGestureRecognizer()..onTap = callback,
          ),
        ],
      ),
    );
  }
}
