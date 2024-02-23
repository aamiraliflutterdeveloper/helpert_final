// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/api_endpoints.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/constants/text_styles.dart';
// import 'package:helpert_app/features/video/model/videos_model.dart';
//
// import '../../../../common_widgets/bottons/custom_elevated_button.dart';
// import '../../../../common_widgets/cancel_publisher_topbar.dart';
// import '../../../../core/data/video_data.dart';
// import '../../../../utils/nav_router.dart';
// import '../../../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/idle_video_module/idle_video_camera_screen.dart';
// import 'congratulation_screen_for_update.dart';
//
// class UpdateUnrelatedQuestionScreen extends StatefulWidget {
//   final VideoBotModel videoBot;
//   UpdateUnrelatedQuestionScreen({Key? key, required this.videoBot})
//       : super(key: key);
//
//   @override
//   State<UpdateUnrelatedQuestionScreen> createState() =>
//       _UpdateUnrelatedQuestionScreenState();
// }
//
// class _UpdateUnrelatedQuestionScreenState
//     extends State<UpdateUnrelatedQuestionScreen> {
//   @override
//   void initState() {
//     VideoModule.defaultVideo.clear();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 40),
//           CancelPublishTopBar(
//             onTap: () {
//               NavRouter.pop(context);
//             },
//           ),
//           UpdateUnrelatedQuestionCard(videoBot: widget.videoBot),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
//
// class UpdateUnrelatedQuestionCard extends StatefulWidget {
//   final VideoBotModel videoBot;
//   const UpdateUnrelatedQuestionCard({Key? key, required this.videoBot})
//       : super(key: key);
//
//   @override
//   State<UpdateUnrelatedQuestionCard> createState() =>
//       _UpdateUnrelatedQuestionCardState();
// }
//
// class _UpdateUnrelatedQuestionCardState
//     extends State<UpdateUnrelatedQuestionCard> {
//   final bool disable = false;
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
//                   color: Colors.black12,
//                   blurRadius: 20,
//                   spreadRadius: 4,
//                   offset: Offset(0, 3)),
//             ],
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 45,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(width: .5, color: AppColors.moon),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Update answer for unrelated questions",
//                               textAlign: TextAlign.center,
//                               style: TextStyles.boldTextStyle()),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         GestureDetector(
//                             behavior: HitTestBehavior.opaque,
//                             onTap: () {
//                               VideoModule.defaultVideo.isEmpty
//                                   ? NavRouter.push(
//                                           context, IdleVideoCameraScreen())
//                                       .then((value) {
//                                       setState(() {
//                                         if (value != null) {
//                                           VideoModule.defaultVideo.add(value);
//                                           VideoModule.defaultVideo;
//                                         }
//                                       });
//                                     })
//                                   : null;
//                             },
//                             child: VideoModule.defaultVideo.isEmpty
//                                 ? Icon(Icons.videocam, size: 40)
//                                 : Container(
//                                     child: Icon(Icons.check,
//                                         size: 25, color: AppColors.success))),
//                         SizedBox(height: 5),
//                         Text(
//                             VideoModule.defaultVideo.isEmpty
//                                 ? "Tap to update answer"
//                                 : "Answer updated successfully",
//                             style: TextStyles.mediumTextStyle()),
//                       ],
//                     ),
//                     Container(),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15),
//               SizedBox(
//                   width: double.infinity,
//                   child: CustomElevatedButton(
//                     disable: disable,
//                     title: 'Continue',
//                     onTap: () {
//                       if (VideoModule.defaultVideo.isEmpty) {
//                         VideoModule.defaultVideo.add(
//                             "${VIDEO_BASE_URL}${widget.videoBot.default_video}");
//                       }
//                       NavRouter.push(context, CongratulationScreenForUpdate());
//                     },
//                   )),
//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
