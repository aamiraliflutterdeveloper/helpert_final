import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/app_colors.dart';


class TermsConditionsParagraph extends StatelessWidget {
  const TermsConditionsParagraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text:
              'By connecting, it’s mean you agree to share information with the Helper Payment Page, this information will be used in accordance with the',
          style: TextStyle(color: AppColors.moon, fontSize: 13),
          children: <TextSpan>[
            TextSpan(
                text: ' Privacy Policy',
                style: TextStyle(color: AppColors.acmeBlue, fontSize: 13),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                  }),
            TextSpan(
                text: ' And Their',
                style: TextStyle(color: AppColors.moon, fontSize: 13),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                  }),
            TextSpan(
                text: ' Terms & Conditions',
                style: TextStyle(color: AppColors.acmeBlue, fontSize: 13),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                  }),
            TextSpan(
                text:
                    ' You can review this permission and stop sharing future information via your Paypal profile at any time.',
                style: TextStyle(color: AppColors.moon, fontSize: 12),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                  }),
          ]),
    );
  }
}
