// // import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
//
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../core/data/video_data.dart';
// import '../../../../../../../utils/nav_router.dart';
// import 'idle_video_camera_screen.dart';
//
// class AddIdleVideo extends StatefulWidget {
//   const AddIdleVideo({Key? key}) : super(key: key);
//
//   @override
//   _AddIdleVideoState createState() => _AddIdleVideoState();
// }
//
// class _AddIdleVideoState extends State<AddIdleVideo> {
//   // BetterPlayerController? _betterPlayerController;
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
//                 "Answer for Idle Video",
//                 style: TextStyles.mediumTextStyle(fontSize: 18),
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         Appdata.isFromSlider = true;
//                         VideoModule.defaultVideo.isEmpty
//                             ? NavRouter.push(context, IdleVideoCameraScreen())
//                                 .then((value) {
//                                 setState(() {
//                                   if (value != null) {
//                                     VideoModule.defaultVideo.add(value);
//                                     VideoModule.defaultVideo;
//                                   }
//                                 });
//                               })
//                             : null;
//                       },
//                       child: VideoModule.defaultVideo.isEmpty
//                           ? Icon(Icons.videocam, size: 40)
//                           : Container(
//                               child: Icon(Icons.check,
//                                   size: 25, color: AppColors.success))),
//                   SizedBox(height: 5),
//                   Text(
//                       VideoModule.defaultVideo.isEmpty
//                           ? "Tap to add Idle Video"
//                           : "Answer added successfully",
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
