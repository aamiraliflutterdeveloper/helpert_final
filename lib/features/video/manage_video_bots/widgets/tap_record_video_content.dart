// import 'dart:async';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/video/manage_video_bots/screens/new_add_video_bot/testing_purpose.dart';
// import 'package:helpert_app/main.dart';
//
// import '../../../../constants/app_colors.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../utils/nav_router.dart';
//
// class TapRecordVideoContent extends StatefulWidget {
//   TapRecordVideoContent({
//     Key? key,
//     required this.cameraController,
//     required this.isRearCameraSelected,
//   }) : super(key: key);
//
//   CameraController cameraController;
//   bool isRearCameraSelected;
//
//   @override
//   State<TapRecordVideoContent> createState() => _TapRecordVideoContentState();
// }
//
// class _TapRecordVideoContentState extends State<TapRecordVideoContent>
//     with TickerProviderStateMixin {
//   Future initCamera(CameraDescription cameraDescription) async {
//     widget.cameraController =
//         CameraController(cameraDescription, ResolutionPreset.high);
//     try {
//       await widget.cameraController.initialize().then((_) {
//         if (!mounted) return;
//         setState(() {});
//       });
//     }
//   }
//
//   bool isRecording = false;
//   XFile? videoFile;
//
//   /// Timer
//
//   @override
//   void initState() {
//     if (isRecording == true && mounted) {
//       widget.cameraController.stopVideoRecording();
//     }
//     super.initState();
//   }
//
//   int count = 0;
//   Timer? timer;
//   starttimer() {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (count < 30) {
//         setState(() {
//           count++;
//         });
//       } else if (count == 30) {
//         timer.cancel();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     if (mounted) timer!.cancel();
//     super.dispose();
//   }
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
//                   isRecording
//                       ? SizedBox.shrink()
//                       : Container(
//                           width: MediaQuery.of(context).size.width,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Introduce Yourself",
//                                   style: TextStyles.regularTextStyle(
//                                       textColor: AppColors.pureWhite),
//                                 ),
//                                 GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onTap: () {
//                                       if (isRecording == false)
//                                         NavRouter.pop(context);
//                                       // showDialog(
//                                       //     barrierDismissible: false,
//                                       //     context: context,
//                                       //     builder: (BuildContext context) {
//                                       //       return CustomAlertDialog(
//                                       //         noPressed: () {
//                                       //           NavRouter.pop(context);
//                                       //         },
//                                       //         yesPressed: () {
//                                       //           clearVideoModuleLists();
//                                       //           Navigator.of(context).popUntil(
//                                       //               (route) => route.isFirst);
//                                       //         },
//                                       //         title:
//                                       //             'Are you sure you want to discard all changes',
//                                       //       );
//                                       //     });
//                                     },
//                                     child: Icon(Icons.cancel,
//                                         color: AppColors.pureWhite))
//                               ],
//                             ),
//                           ),
//                         ),
//                   SizedBox(height: 5),
//                   isRecording
//                       ? SizedBox.shrink()
//                       : Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Text(
//                             "Read Below Script",
//                             style: TextStyles.regularTextStyle(
//                                 textColor: AppColors.success, fontSize: 16),
//                           ),
//                         ),
//                   SizedBox(height: 5),
//                   isRecording
//                       ? SizedBox.shrink()
//                       : Container(
//                           width: MediaQuery.of(context).size.width,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(
//                               "Hi, this is Sadik. I have over 10 years of experience as Physiotherapist and I will be sharing my experience with you today to help millions of people like you! ",
//                               style: TextStyles.regularTextStyle(
//                                   textColor: AppColors.pureWhite, fontSize: 16),
//                             ),
//                           ),
//                         ),
//                   SizedBox(height: 5),
//                   isRecording
//                       ? SizedBox.shrink()
//                       : Container(
//                           width: MediaQuery.of(context).size.width,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(
//                               "So tap the mic and ask me any questions related to the same:)",
//                               style: TextStyles.regularTextStyle(
//                                   textColor: AppColors.pureWhite, fontSize: 16),
//                             ),
//                           ),
//                         ),
//                   if (isRecording)
//                     Text("$count",
//                         style: TextStyles.mediumTextStyle(
//                             textColor: AppColors.pureWhite))
//                 ],
//               )),
//           Positioned(
//               bottom: 50,
//               child: Column(
//                 children: [
//                   isRecording
//                       ? SizedBox()
//                       : Text(
//                           "Tap to Start RECORDING",
//                           style: TextStyles.boldTextStyle(
//                               textColor: AppColors.pureWhite),
//                         ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           isRecording
//                               ? SizedBox.shrink()
//                               : Container(width: 30),
//                           GestureDetector(
//                             behavior: HitTestBehavior.opaque,
//                             onTap: () async {
//                               setState(() {
//                                 isRecording = !isRecording;
//                                 // videoPath = path;
//                               });
//                               // NavRouter.push(context, route)
//                               if (isRecording == true) {
//                                 starttimer();
//                                 await widget.cameraController
//                                     .startVideoRecording();
//                                 await Future.delayed(
//                                     const Duration(seconds: 30));
//                                 if (mounted && isRecording == true) {
//                                   await widget.cameraController
//                                       .stopVideoRecording()
//                                       .then((XFile? file) {
//                                     if (file != null) {
//                                       // showInSnackBar('Video recorded to ${file.path}');
//
//                                       setState(() {
//                                         isRecording = false;
//                                         videoFile = file;
//                                       });
//                                       // _startVideoPlayer();
//                                     }
//                                   });
//                                   await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => TestingPurpose(
//                                               // file: videoFile!,
//                                               )));
//                                 }
//                               } else if (isRecording == false) {
//                                 await widget.cameraController
//                                     .stopVideoRecording()
//                                     .then((XFile? file) {
//                                   if (file != null) {
//                                     // showInSnackBar('Video recorded to ${file.path}');
//
//                                     setState(() {
//                                       videoFile = file;
//                                     });
//                                   }
//                                 });
//                                 await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => TestingPurpose(
//                                             // file: videoFile!,
//                                             )));
//                               }
//                             },
//                             child: Icon(
//                               Icons.radio_button_on,
//                               color: isRecording
//                                   ? AppColors.failure
//                                   : AppColors.pureWhite,
//                               size: 80,
//                             ),
//                           ),
//                           isRecording
//                               ? SizedBox.shrink()
//                               : GestureDetector(
//                                   behavior: HitTestBehavior.opaque,
//                                   onTap: () {
//                                     setState(() => widget.isRearCameraSelected =
//                                         !widget.isRearCameraSelected);
//                                     initCamera(cameras[
//                                         widget.isRearCameraSelected ? 0 : 1]);
//                                   },
//                                   child: Icon(Icons.cameraswitch,
//                                       color: AppColors.pureWhite, size: 30),
//                                 ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   isRecording
//                       ? SizedBox(height: 15)
//                       : Row(
//                           children: [
//                             Icon(
//                               Icons.info,
//                               color: AppColors.pureWhite,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               "Ensure that your face fits well within the frame",
//                               style: TextStyles.regularTextStyle(
//                                   fontSize: 13, textColor: AppColors.pureWhite),
//                             ),
//                           ],
//                         )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
