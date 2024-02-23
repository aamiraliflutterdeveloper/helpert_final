// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/video/model/videos_model.dart';
//
// import '../../../../common_widgets/bottons/custom_elevated_button.dart';
// import '../../../../common_widgets/textfield/custom_textformfield.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../core/data/video_data.dart';
// import '../../../../utils/nav_router.dart';
// import '../screens/update_video_category_screen.dart';
//
// class UpdateTopicCard extends StatefulWidget {
//   const UpdateTopicCard({
//     required this.videoBot,
//     Key? key,
//     required this.disable,
//   }) : super(key: key);
//   final VideoBotModel videoBot;
//   final bool disable;
//
//   @override
//   State<UpdateTopicCard> createState() => _UpdateTopicCardState();
// }
//
// class _UpdateTopicCardState extends State<UpdateTopicCard> {
//   final topicController = TextEditingController();
//
//   @override
//   void initState() {
//     topicController.text = widget.videoBot.main_title;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 20,
//                 spreadRadius: 4,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Expanded(
//                     child: Column(
//                   // physics: const ClampingScrollPhysics(),
//                   children: [
//                     SizedBox(height: 20),
//                     Text(
//                       "Update your videobots",
//                       style: TextStyles.regularTextStyle(),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "When users visit’s your profile and ask questions these videos will be played, Which resembles to 1 on 1 video call.  so record the videos for most questions asked to you by your followers.",
//                       textAlign: TextAlign.center,
//                       style: TextStyles.regularTextStyle(fontSize: 13),
//                     ),
//                     SizedBox(height: 25),
//                     CustomTextFormField(
//                         readOnly: true,
//                         onTap: () {},
//                         keyboardType: TextInputType.text,
//                         controller: topicController,
//                         labelText: 'Today’s topic you want to talk about',
//                         onChanged: (val) {}),
//                     Spacer(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: CustomElevatedButton(
//                         disable: widget.disable,
//                         title: 'Continue Recording',
//                         onTap: () {
//                           if (topicController.text.isEmpty) {
//                             BotToast.showText(text: 'please enter your topic');
//                           } else {
//                             VideoModule.topic.add(topicController.text);
//                             NavRouter.push(
//                                 context,
//                                 UpdateVideoCategoryScreen(
//                                     videoBot: widget.videoBot));
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                   ],
//                 ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
