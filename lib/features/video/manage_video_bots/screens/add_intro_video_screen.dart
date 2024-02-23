import 'package:flutter/material.dart';

import '../../../../common_widgets/cancel_publisher_topbar.dart';
import '../../../../core/data/video_data.dart';

class AddIntroVideoScreen extends StatefulWidget {
  const AddIntroVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddIntroVideoScreen> createState() => _AddIntroVideoScreenState();
}

class _AddIntroVideoScreenState extends State<AddIntroVideoScreen> {
  bool disable = false;

  @override
  void initState() {
    VideoModule.introVideo.clear();
    VideoModule.defaultVideo.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 40),
          CancelPublishTopBar(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // IntroVideoCard(disable: disable),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
