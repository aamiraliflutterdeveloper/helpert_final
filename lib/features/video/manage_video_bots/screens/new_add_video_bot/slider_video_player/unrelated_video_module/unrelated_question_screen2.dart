// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
// import 'package:helpert_app/features/video/manage_video_bots/screens/new_add_video_bot/slider_video_player/unrelated_video_module/unrelated_question_camera_screen.dart';
//
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../utils/nav_router.dart';
//
// class AddUnrelatedQuestionVideo2 extends StatefulWidget {
//   const AddUnrelatedQuestionVideo2({Key? key}) : super(key: key);
//
//   @override
//   _AddUnrelatedQuestionVideo2State createState() =>
//       _AddUnrelatedQuestionVideo2State();
// }
//
// class _AddUnrelatedQuestionVideo2State
//     extends State<AddUnrelatedQuestionVideo2> {
//   BetterPlayerController? _betterPlayerController;
//   bool isVideoFinished = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 7.0, right: 7, top: 10, bottom: 10),
//       child: Container(
//         decoration: BoxDecoration(
//             color: AppColors.pureWhite,
//             borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Unrelated Question Video",
//                 style: TextStyles.mediumTextStyle(fontSize: 18),
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         Appdata.isFromSlider = true;
//                         NavRouter.push(context, UnrelatedQuestionCameraScreen())
//                             .then((value) {
//                           setState(() {});
//                         });
//                       },
//                       child: Icon(Icons.videocam, size: 40)),
//                   SizedBox(height: 5),
//                   Text("Tap to add unrelated question video",
//                       style: TextStyles.mediumTextStyle()),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
