import 'package:flutter/material.dart';

import '../model/videos_model.dart';

class IntroductionVideo extends StatelessWidget {
  final VideoBotModel videoData;
  const IntroductionVideo({Key? key, required this.videoData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
