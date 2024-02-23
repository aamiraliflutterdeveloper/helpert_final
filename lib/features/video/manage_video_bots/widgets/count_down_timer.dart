import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class CountdownTimer extends AnimatedWidget {
  const CountdownTimer({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '00:${clockTimer.inSeconds.remainder(30).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyles.mediumTextStyle(textColor: AppColors.black),
    );
  }
}
