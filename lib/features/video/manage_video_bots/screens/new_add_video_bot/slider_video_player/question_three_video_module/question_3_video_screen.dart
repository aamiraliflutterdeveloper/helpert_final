// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
//
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../utils/nav_router.dart';
// import 'question_three_video_camera_screen.dart';
//
// class QuestionThreeVideoScreen extends StatefulWidget {
//   const QuestionThreeVideoScreen({Key? key}) : super(key: key);
//
//   @override
//   _QuestionThreeVideoScreenState createState() =>
//       _QuestionThreeVideoScreenState();
// }
//
// class _QuestionThreeVideoScreenState extends State<QuestionThreeVideoScreen> {
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
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Text(
//                   "Can you brief us about your business?",
//                   style: TextStyles.mediumTextStyle(fontSize: 18),
//                 ),
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         Appdata.isFromSlider = true;
//                         NavRouter.push(context, QuestionThreeCameraScreen());
//                       },
//                       child: Icon(Icons.videocam, size: 40)),
//                   SizedBox(height: 5),
//                   Text("Tap to add answer",
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
