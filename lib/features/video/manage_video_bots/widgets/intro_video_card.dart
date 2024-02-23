// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/core/data/video_data.dart';
//
// import '../../../../common_widgets/bottons/custom_elevated_button.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../utils/nav_router.dart';
// import '../screens/add_question_screen.dart';
// import '../screens/new_add_video_bot/slider_video_player/idle_video_module/idle_video_camera_screen.dart';
//
// class IntroVideoCard extends StatefulWidget {
//   const IntroVideoCard({
//     Key? key,
//     required this.disable,
//   }) : super(key: key);
//
//   final bool disable;
//
//   @override
//   State<IntroVideoCard> createState() => _IntroVideoCardState();
// }
//
// class _IntroVideoCardState extends State<IntroVideoCard> {
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
//                       "Create your videobots",
//                       style: TextStyles.regularTextStyle(),
//                     ),
//                     SizedBox(height: 10),
//                     Spacer(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: CustomElevatedButton(
//                         disable: widget.disable,
//                         title: 'Continue Recording',
//                         onTap: () {
//                           if (VideoModule.introVideo.isEmpty) {
//                             BotToast.showText(
//                                 text: 'please record Introductory Video');
//                           } else {
//                             NavRouter.push(context, AddQuestionScreen());
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     GestureDetector(
//                         behavior: HitTestBehavior.opaque,
//                         onTap: () {
//                           VideoModule.introVideo.isEmpty
//                               ? NavRouter.push(context, IdleVideoCameraScreen())
//                                   .then((value) async {
//                                   if (value != null) {
//                                     VideoModule.introVideo.add(value);
//                                     VideoModule.introVideo;
//                                   }
//                                   setState(() {});
//                                 })
//                               : null;
//                         },
//                         child: VideoModule.introVideo.isEmpty
//                             ? Icon(Icons.videocam, size: 40)
//                             : Container(
//                                 child: Icon(Icons.check,
//                                     size: 25, color: AppColors.success))),
//                     SizedBox(height: 20),
//                     Text(
//                         VideoModule.introVideo.isEmpty
//                             ? "Tap to Record Intro Video"
//                             : "Video Recorded Successfully",
//                         style: TextStyles.mediumTextStyle()),
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
