// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
//
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../utils/nav_router.dart';
// import 'question_two_video_camera_screen.dart';
//
// class QuestionTwoVideoScreen extends StatefulWidget {
//   const QuestionTwoVideoScreen({Key? key}) : super(key: key);
//
//   @override
//   _QuestionTwoVideoScreenState createState() => _QuestionTwoVideoScreenState();
// }
//
// class _QuestionTwoVideoScreenState extends State<QuestionTwoVideoScreen> {
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
//                   "What are your top 3 preparation tips for landing a job at 10000 startups",
//                   style: TextStyles.mediumTextStyle(fontSize: 18),
//                 ),
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         Appdata.isFromSlider = true;
//                         NavRouter.push(
//                             context, const QuestionTwoCameraScreen());
//                       },
//                       child: const Icon(Icons.videocam, size: 40)),
//                   const SizedBox(height: 5),
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
