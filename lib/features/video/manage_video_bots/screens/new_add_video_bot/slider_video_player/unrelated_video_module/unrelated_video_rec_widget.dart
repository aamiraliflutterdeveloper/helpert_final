// import 'dart:async';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../../../constants/app_colors.dart';
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../utils/nav_router.dart';
// import '../../../../../../reusable_video_list/app_data.dart';
// import '../../../../../../reusable_video_list/reusable_video_list_page.dart';
// import '../idle_video_module/recorded_video_view_screen.dart';
//
// class UnrelatedVideoRecWidget extends StatefulWidget {
//   final CameraController cameraController;
//   final GestureTapCallback? callBack;
//   UnrelatedVideoRecWidget(
//       {Key? key, required this.cameraController, this.callBack})
//       : super(key: key);
//
//   @override
//   _UnrelatedVideoRecWidgetState createState() =>
//       _UnrelatedVideoRecWidgetState();
// }
//
// class _UnrelatedVideoRecWidgetState extends State<UnrelatedVideoRecWidget>
//     with TickerProviderStateMixin {
//   bool isRecording = false;
//   XFile? videoFile;
//
//   /// Timer
//   ///
//   bool isStopped = false; //global
//   int counter = 0;
//   sec5Timer() async {
//     Timer.periodic(Duration(seconds: 1), (timer) async {
//       secondsText = false;
//       whiteButton = false;
//       if (counter == 0) {
//         lights = true;
//         setState(() {});
//       } else if (counter == 1) {
//         lights = false;
//         camera = true;
//         setState(() {});
//       } else if (counter == 2) {
//         lights = false;
//         camera = false;
//         action = true;
//         setState(() {});
//       } else if (counter == 3) {
//         blink = true;
//         setState(() {});
//         Future.delayed(Duration(milliseconds: 100), () {
//           setState(() {
//             blink = false;
//           });
//         });
//         lights = false;
//         camera = false;
//         action = false;
//         secondsText = true;
//
//         isRecording = true;
//         redButton = true;
//
//         _startTimer();
//         timer.cancel();
//       }
//       counter = counter + 1;
//     });
//
//     if (isRecording = true) {
//       /// To start video recording ...
//       await widget.cameraController.startVideoRecording();
//
//       // if (mounted && isRecording == true) {
//       //   await widget.cameraController
//       //       .stopVideoRecording()
//       //       .then((XFile? file) {
//       //     if (file != null) {
//       //       // showInSnackBar('Video recorded to ${file.path}');
//       //
//       //       setState(() {
//       //         isRecording = false;
//       //         videoFile = file;
//       //       });
//       //       // _startVideoPlayer();
//       //     }
//       //   });
//       //   await Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //           builder: (context) => VideoViewScreen(
//       //             file: videoFile!,
//       //           )));
//       // }
//
//     }
//   }
//
//   @override
//   void initState() {
//     if (isRecording == true && mounted) {
//       widget.cameraController.stopVideoRecording();
//     }
//
//     super.initState();
//   }
//
//   int _count = 0;
//   late Timer _recordingTimer;
//
//   void _startTimer() {
//     _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
//       if (mounted) {
//         setState(() {
//           if (_count < 21) _count = _count + 1;
//         });
//         if (_count == 20) {
//           if (isRecording == true) {
//             await widget.cameraController
//                 .stopVideoRecording()
//                 .then((XFile? file) {
//               if (file != null) {
//                 // showInSnackBar('Video recorded to ${file.path}');
//
//                 Appdata.videoList[2] = file.path;
//
//                 videoFile = file;
//                 whiteButton = true;
//                 isRecording = false;
//                 secondsText = true;
//                 redButton = false;
//                 _count = 0;
//                 counter = 0;
//                 _recordingTimer.cancel();
//               }
//             });
//             await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         RecordedVideoViewScreen(index: 2))).then((value) {
//               if (mounted) setState(() {});
//             });
//           }
//           _recordingTimer.cancel();
//         }
//       }
//     });
//   }
//
//   int count = 0;
//   Timer? animationTimer;
//
//   bool lights = false;
//   bool camera = false;
//   bool action = false;
//   bool blink = false;
//   bool secondsText = true;
//   // bool disappearWhiteButton = false;
//   bool whiteButton = true;
//   bool redButton = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaSize = MediaQuery.of(context).size;
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           (widget.cameraController.value.isInitialized)
//               ? Center(
//                   child: Transform.scale(
//                       scale: 1 /
//                           (widget.cameraController.value.aspectRatio *
//                               mediaSize.aspectRatio),
//                       child: CameraPreview(widget.cameraController)))
//               : Container(
//                   color: Colors.black,
//                   child: const Center(child: CircularProgressIndicator())),
//           Positioned(
//               top: 10,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Answer for unrelated questions",
//                             style: TextStyles.regularTextStyle(
//                                 textColor: AppColors.pureWhite, fontSize: 16),
//                           ),
//                           GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               onTap: () {
//                                 if (Appdata.isFromSlider) {
//                                 } else {
//                                   Navigator.pop(context);
//                                   NavRouter.pop(context);
//                                   NavRouter.pop(context);
//                                   NavRouter.pop(context);
//                                   NavRouter.pop(context);
//                                   NavRouter.pushReplacement(
//                                       context, ReusableVideoListPage());
//                                 }
//                               },
//                               child: Icon(
//                                 Icons.close,
//                                 color: Colors.white,
//                               ))
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       "Read Below Script",
//                       style: TextStyles.regularTextStyle(
//                           textColor: Color(0xFF49eae4), fontSize: 12),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         "Sorry, i did not understand your question!. Kindly rephrase or refer to the questions below and ask again. ",
//                         style: TextStyles.regularTextStyle(
//                             textColor: AppColors.pureWhite, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         "If you have something specific, you can get on an exclusive consultation call with me by pressing the Book 1:1 button ",
//                         style: TextStyles.mediumTextStyle(
//                             textColor: AppColors.pureWhite, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//           Positioned(
//               bottom: 60,
//               child: Column(
//                 children: [
//                   lights == true
//                       ? Row(
//                           children: [
//                             Text("Lights ",
//                                 style: TextStyles.mediumTextStyle(
//                                     textColor: AppColors.pureWhite,
//                                     fontSize: 35)),
//                             Container(
//                               height: 180,
//                             ),
//                           ],
//                         )
//                       : camera == true
//                           ? Row(
//                               children: [
//                                 Text("Camera ",
//                                     style: TextStyles.mediumTextStyle(
//                                         textColor: AppColors.pureWhite,
//                                         fontSize: 35)),
//                                 Container(
//                                   height: 180,
//                                 ),
//                               ],
//                             )
//                           : action == true
//                               ? Row(
//                                   children: [
//                                     Text("Action! ",
//                                         style: TextStyles.mediumTextStyle(
//                                             textColor: AppColors.pureWhite,
//                                             fontSize: 35)),
//                                     Container(
//                                       height: 180,
//                                     ),
//                                   ],
//                                 )
//                               : isRecording == true
//                                   ? Text(
//                                       _count < 10
//                                           ? '00:0$_count'
//                                           : '00:$_count',
//                                       style: TextStyles.mediumTextStyle(
//                                           textColor: AppColors.pureWhite,
//                                           fontSize: 35))
//                                   : Row(
//                                       children: [
//                                         Text(
//                                           "Tap to Start ",
//                                           style: TextStyles.boldTextStyle(
//                                               textColor: AppColors.pureWhite,
//                                               fontSize: 21),
//                                         ),
//                                         Text(
//                                           "REC",
//                                           style: TextStyles.boldTextStyle(
//                                               textColor: AppColors.warning,
//                                               fontSize: 21),
//                                         ),
//                                       ],
//                                     ),
//                   secondsText == true
//                       ? Text(
//                           "Answer for at least 5 seconds",
//                           style: TextStyles.regularTextStyle(
//                               textColor: AppColors.pureWhite, fontSize: 11),
//                         )
//                       : SizedBox(height: 5),
//                   SizedBox(height: 10),
//                   if (whiteButton == true)
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             isRecording
//                                 ? const SizedBox.shrink()
//                                 : Container(width: 30),
//                             GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               onDoubleTap: null,
//                               onTap: () async {
//                                 sec5Timer();
//                               },
//                               child: const Icon(
//                                 Icons.radio_button_on,
//                                 color: AppColors.pureWhite,
//                                 // isRecording
//                                 //     ? AppColors.failure
//                                 //     :
//                                 size: 80,
//                               ),
//                             ),
//                             isRecording
//                                 ? const SizedBox.shrink()
//                                 : GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onTap: widget.callBack,
//                                     child: const Icon(Icons.cameraswitch,
//                                         color: AppColors.pureWhite, size: 30),
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   if (redButton == true)
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: GestureDetector(
//                             behavior: HitTestBehavior.opaque,
//                             onDoubleTap: null,
//                             onTap: () async {
//                               // NavRouter.push(context, route)
//                               if (mounted && isRecording == true) {
//                                 whiteButton = true;
//                                 isRecording = false;
//                                 secondsText = true;
//                                 redButton = false;
//                                 _count = 0;
//                                 counter = 0;
//                                 _recordingTimer.cancel();
//                                 await widget.cameraController
//                                     .stopVideoRecording()
//                                     .then((XFile? file) {
//                                   if (file != null) {
//                                     // showInSnackBar('Video recorded to ${file.path}');
//
//                                     Appdata.videoList[2] = file.path;
//                                     setState(() {
//                                       videoFile = file;
//                                     });
//                                     // _startVideoPlayer();
//                                   }
//                                 });
//
//                                 await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             RecordedVideoViewScreen(
//                                               index: 2,
//                                             ))).then((value) {
//                                   if (mounted) setState(() {});
//                                 });
//                               }
//                             },
//                             child: const Icon(
//                               Icons.radio_button_on,
//                               color: AppColors.failure,
//                               size: 80,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               )),
//           if (blink)
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: AppColors.black.withOpacity(.6),
//             ),
//         ],
//       ),
//     );
//   }
// }
