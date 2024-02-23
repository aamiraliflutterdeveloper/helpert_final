// 'package:helpert_app/utils/nav_router.dart';
//
// import '../../../../../../../constants/app_colors.dart';
// import '../../../../../../../constants/text_styles.dart';
//
// class IdleVideoRecWidget extends StatefulWidget {
//   final CameraController cameraController;
//   final GestureTapCallback? callBack;
//   IdleVideoRecWidget(
//       {Key? key, required this.callBack, required this.cameraController})
//       : super(key: key);
//
//   @override
//   _IdleVideoRecWidgetState createState() => _IdleVideoRecWidgetState();
// }
//
// class _IdleVideoRecWidgetState extends State<IdleVideoRecWidget>
//     with TickerProviderStateMixin {
//   bool isRecording = false;
//   XFile? videoFile;
//
//   /// Timer
//   ///
//   bool isStopped = false; //global
//   int counter = 0;
//   sec5Timer() async {
//     animationTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
//       if (mounted) {
//         secondsText = false;
//         whiteButton = false;
//
//         setState(() {});
//         if (counter == 0) {
//           lights = true;
//
//           setState(() {});
//         } else if (counter == 1) {
//           lights = false;
//           camera = true;
//           setState(() {});
//         } else if (counter == 2) {
//           lights = false;
//           camera = false;
//           action = true;
//
//           setState(() {});
//         } else if (counter == 3) {
//           blink = true;
//           setState(() {});
//           Future.delayed(Duration(milliseconds: 100), () {
//             setState(() {
//               blink = false;
//             });
//           });
//           lights = false;
//           camera = false;
//           action = false;
//           isRecording = true;
//           redButton = true;
//           setState(() {});
//           _startTimer();
//           timer.cancel();
//         }
//       }
//       counter = counter + 1;
//     });
//
//     if (isRecording = true) {
//       /// To start video recording ...
//       await widget.cameraController.startVideoRecording();
//       // await Future.delayed(const Duration(seconds: 13));
//       // if (mounted && isRecording == true) {
//       //   await widget.cameraController
//       //       .stopVideoRecording()
//       //       .then((XFile? file) {
//       //     if (file != null) {
//       //       // showInSnackBar('Video recorded to ${file.path}');
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
//     super.initState();
//   }
//
//   int _count = 10;
//   late Timer _recordingTimer;
//
//   void _startTimer() {
//     _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
//       if (mounted) {
//         setState(() {
//           if (_count > 0) _count = _count - 1;
//         });
//         if (_count == 0) {
//           if (isRecording == true && mounted) {
//             await widget.cameraController
//                 .stopVideoRecording()
//                 .then((XFile? file) {
//               if (file != null) {
//                 // showInSnackBar('Video recorded to ${file.path}');
//
//                 Appdata.videoList[0] = file.path;
//                 videoFile = file;
//                 whiteButton = true;
//                 isRecording = false;
//                 secondsText = true;
//                 redButton = false;
//                 _count = 10;
//                 counter = 0;
//               }
//             });
//             await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         RecordedVideoViewScreen(index: 0))).then((value) {
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
//   bool whiteButton = true;
//   bool redButton = false;
//
//   @override
//   void dispose() {
//     widget.cameraController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaSize = MediaQuery.of(context).size;
//     return SizedBox(
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
//                   const SizedBox(height: 5),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Idle Video",
//                             style: TextStyles.regularTextStyle(
//                                 textColor: AppColors.pureWhite, fontSize: 16),
//                           ),
//                           GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               onTap: () {
//                                 NavRouter.pop(context);
//                               },
//                               child: Icon(
//                                 Icons.close,
//                                 color: AppColors.pureWhite,
//                               ))
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       "Follow Below Script",
//                       style: TextStyles.regularTextStyle(
//                           textColor: Color(0xFF49eae4), fontSize: 12),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         "A 10 sec video of your being Idle - not Speaking - and listening to the question being asked to you",
//                         style: TextStyles.mediumTextStyle(
//                             textColor: AppColors.pureWhite, fontSize: 17),
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
//                                   ? Text("$_count ",
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
//                           "Answer for at least 10 seconds",
//                           style: TextStyles.regularTextStyle(
//                               textColor: AppColors.pureWhite, fontSize: 11),
//                         )
//                       : const SizedBox(height: 5),
//                   const SizedBox(height: 10),
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
//                               if (isRecording == true) {
//                                 _recordingTimer.cancel();
//                                 isRecording = false;
//                                 _count = 10;
//                                 counter = 0;
//                               }
//                               await widget.cameraController
//                                   .stopVideoRecording()
//                                   .then((XFile? file) {
//                                 if (file != null) {
//                                   // showInSnackBar('Video recorded to ${file.path}');
//
//                                   Appdata.videoList[0] = file.path;
//                                   setState(() {
//                                     videoFile = file;
//                                   });
//                                   // _startVideoPlayer();
//                                 }
//                               });
//
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           RecordedVideoViewScreen(
//                                             index: 0,
//                                           ))).then((value) {
//                                 if (mounted)
//                                   setState(() {
//                                     redButton = false;
//                                     secondsText = true;
//                                     whiteButton = true;
//                                   });
//                               });
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
