// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
//
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../utils/nav_router.dart';
// import 'question_one_video_camera_screen.dart';
//
// class QuestionOneVideoScreen extends StatefulWidget {
//   const QuestionOneVideoScreen({Key? key}) : super(key: key);
//
//   @override
//   _QuestionOneVideoScreenState createState() => _QuestionOneVideoScreenState();
// }
//
// class _QuestionOneVideoScreenState extends State<QuestionOneVideoScreen> {
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
//                   "What research did you do about 10000 startups before sending in your job application?",
//                   style: TextStyles.mediumTextStyle(fontSize: 18),
//                 ),
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         Appdata.isFromSlider = true;
//                         NavRouter.push(context, QuestionOneCameraScreen());
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
