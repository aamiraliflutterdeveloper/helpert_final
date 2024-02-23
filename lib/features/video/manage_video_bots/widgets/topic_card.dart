import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/bottons/custom_elevated_button.dart';
import '../../../../common_widgets/textfield/custom_textformfield.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/data/video_data.dart';
import '../../../../utils/nav_router.dart';
import '../screens/video_category_screen.dart';

class TopicCard extends StatefulWidget {
  const TopicCard({
    Key? key,
    required this.disable,
  }) : super(key: key);

  final bool disable;

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  final topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                spreadRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  // physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Create your videobots",
                      style: TextStyles.regularTextStyle(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "When users visit’s your profile and ask questions these videos will be played, Which resembles to 1 on 1 video call.  so record the videos for most questions asked to you by your followers.",
                      textAlign: TextAlign.center,
                      style: TextStyles.regularTextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 25),
                    CustomTextFormField(
                        readOnly: true,
                        onTap: () {},
                        keyboardType: TextInputType.text,
                        controller: topicController,
                        labelText: 'Today’s topic you want to talk about',
                        onChanged: (val) {}),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        disable: widget.disable,
                        title: 'Continue Recording',
                        onTap: () {
                          // // if (VideoModule.topic.isNotEmpty) {
                          //   VideoModule.topic.clear();
                          // }

                          if (topicController.text.isEmpty) {
                            BotToast.showText(text: 'please enter your topic');
                          } else {
                            VideoModule.topic.add(topicController.text);
                            NavRouter.push(context, AddCategoryScreen());
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
