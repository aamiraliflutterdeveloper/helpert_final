// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
//
// import '../../../../../../../constants/app_colors.dart';
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../core/data/video_data.dart';
// import '../../../../../../../utils/nav_router.dart';
// import 'intro_video_camera_screen.dart';
//
// class AddIntroVideoScreen2 extends StatefulWidget {
//   const AddIntroVideoScreen2({Key? key}) : super(key: key);
//
//   @override
//   _AddIntroVideoScreen2State createState() => _AddIntroVideoScreen2State();
// }
//
// class _AddIntroVideoScreen2State extends State<AddIntroVideoScreen2> {
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
//                 "Intro Video",
//                 style: TextStyles.mediumTextStyle(fontSize: 18),
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         Appdata.isFromSlider = true;
//                         NavRouter.push(context, const IntroVideoCameraScreen())
//                             .then((value) {
//                           setState(() {
//                             if (value != null) {
//                               VideoModule.defaultVideo.add(value);
//                               VideoModule.defaultVideo;
//                             }
//                           });
//                         });
//                       },
//                       child: const Icon(Icons.videocam, size: 40)),
//                   const SizedBox(height: 5),
//                   Text("Tap to add intro video",
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
