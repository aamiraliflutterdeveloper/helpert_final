import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';

class Countdown extends AnimatedWidget {
  final int timeLimit;
  const Countdown({Key? key, required this.timeLimit, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '00:${clockTimer.inSeconds.remainder(timeLimit).toString().padLeft(2, '0')}';

    // print('animation.value  ${animation.value} ');
    // print('inMinutes ${clockTimer.inMinutes.toString()}');
    // print('inSeconds ${clockTimer.inSeconds.toString()}');
    // print(
    //     'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text(
      timerText,
      style: TextStyle(
          fontSize: 22, color: AppColors.failure, fontWeight: FontWeight.bold),
    );
  }
}
