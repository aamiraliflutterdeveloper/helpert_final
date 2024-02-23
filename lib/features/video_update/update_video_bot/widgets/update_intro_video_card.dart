// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/api_endpoints.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/core/data/video_data.dart';
// import 'package:helpert_app/features/video/model/videos_model.dart';
//
// import '../../../../common_widgets/bottons/custom_elevated_button.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../utils/nav_router.dart';
// import '../../../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/idle_video_module/idle_video_camera_screen.dart';
// import '../screens/update_question_screen.dart';
//
// class UpdateIntroVideoCard extends StatefulWidget {
//   final VideoBotModel videoBot;
//   const UpdateIntroVideoCard({
//     required this.videoBot,
//     Key? key,
//     required this.disable,
//   }) : super(key: key);
//
//   final bool disable;
//
//   @override
//   State<UpdateIntroVideoCard> createState() => _UpdateIntroVideoCardState();
// }
//
// class _UpdateIntroVideoCardState extends State<UpdateIntroVideoCard> {
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
//                     Spacer(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: CustomElevatedButton(
//                         disable: widget.disable,
//                         title: 'Continue Recording',
//                         onTap: () {
//                           if (VideoModule.introVideo.isEmpty) {
//                             VideoModule.introVideo.add(
//                                 "${VIDEO_BASE_URL}${widget.videoBot.video}");
//                           }
//                           NavRouter.push(context,
//                               UpdateQuestionScreen(videoBot: widget.videoBot));
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
//                             ? "Tap to Update Intro Video"
//                             : "Video Updated Successfully",
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
