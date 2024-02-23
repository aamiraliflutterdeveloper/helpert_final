import 'package:flutter/material.dart';
import 'package:helpert_app/core/data/video_data.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../common_widgets/cancel_publisher_topbar.dart';
import '../widgets/topic_card.dart';

class AddTopicScreen extends StatefulWidget {
  const AddTopicScreen({Key? key}) : super(key: key);

  @override
  State<AddTopicScreen> createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends State<AddTopicScreen> {
  final topicController = TextEditingController();

  bool disable = false;
  @override
  initState() {
    // VideoModule.topic.clear();
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
              NavRouter.pop(context);
              topicController.text = '';
              VideoModule.topic.clear();
            },
          ),
          TopicCard(disable: disable),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
