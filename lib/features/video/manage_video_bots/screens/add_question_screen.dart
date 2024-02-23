import 'package:flutter/material.dart';

import '../../../../common_widgets/cancel_publisher_topbar.dart';
import '../../../../core/data/video_data.dart';
import '../../../../utils/nav_router.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  @override
  void initState() {
    clearVideoModuleLists();
    super.initState();
  }

  bool disable = false;

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

              //   showDialog(
              //       barrierDismissible: false,
              //       context: context,
              //       builder: (BuildContext context) {
              //         return CustomAlertDialog(
              //             noPressed: () {
              //               NavRouter.pop(context);
              //             },
              //             yesPressed: () {
              //               clearVideoModuleLists();
              //               Navigator.of(context)
              //                   .popUntil((route) => route.isFirst);
              //             },
              //             title: 'Are you sure you want to discard all changes');
              //       });
              // },
            },
          ),
          // QuestionCard(disable: disable),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
