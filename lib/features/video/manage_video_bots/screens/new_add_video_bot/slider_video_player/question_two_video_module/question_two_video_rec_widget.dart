// import 'dart:async';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../../../constants/app_colors.dart';
// import '../../../../../../../constants/text_styles.dart';
// import '../../../../../../../utils/nav_router.dart';
// import '../../../../../../reusable_video_list/app_data.dart';
// import '../../../../../../reusable_video_list/reusable_video_list_page.dart';
// import '../custom_question_dialog.dart';
// import '../idle_video_module/recorded_video_view_screen.dart';
//
// class QuestionTwoVideoRecWidget extends StatefulWidget {
//   final CameraController cameraController;
//   final GestureTapCallback? callBack;
//   QuestionTwoVideoRecWidget(
//       {Key? key, required this.cameraController, this.callBack})
//       : super(key: key);
//
//   @override
//   _QuestionTwoVideoRecWidgetState createState() =>
//       _QuestionTwoVideoRecWidgetState();
// }
//
// class _QuestionTwoVideoRecWidgetState extends State<QuestionTwoVideoRecWidget>
//     with TickerProviderStateMixin {
//   bool isRecording = false;
//   XFile? videoFile;
//   String question = Appdata.recommendedQuestions.isEmpty
//       ? 'Please enter your question'
//       : Appdata.recommendedQuestions[0].question;
//   String? script;
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
//
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
//     questionController.text = question;
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
//           if (_count < 31) _count = _count + 1;
//         });
//         if (_count == 30) {
//           if (isRecording == true) {
//             await widget.cameraController
//                 .stopVideoRecording()
//                 .then((XFile? file) {
//               if (file != null) {
//                 // showInSnackBar('Video recorded to ${file.path}');
//
//                 Appdata.videoList[4] = file.path;
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
//                     builder: (context) => RecordedVideoViewScreen(
//                           index: 4,
//                           question: question,
//                         ))).then((value) {
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
//   Timer? timer;
//
//   bool lights = false;
//   bool camera = false;
//   bool action = false;
//   bool blink = false;
//   bool secondsText = true;
//   bool whiteButton = true;
//   bool redButton = false;
//   TextEditingController questionController = TextEditingController();
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
//               left: 2,
//               right: 2,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 8.0, right: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: RichText(
//                               text: TextSpan(
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                       text: questionController.text + '   ',
//                                       style: TextStyles.regularTextStyle(
//                                           textColor: AppColors.pureWhite,
//                                           fontSize: 16)),
//                                   TextSpan(
//                                       recognizer: new TapGestureRecognizer()
//                                         ..onTap = () {
//                                           EditAndUpdateQuestion(context)
//                                               .then((value) {
//                                             setState(() {});
//                                           });
//                                         },
//                                       text: 'Edit',
//                                       style: TextStyle(
//                                           decoration: TextDecoration.underline,
//                                           decorationThickness: 2,
//                                           fontSize: 17,
//                                           color: AppColors.pureWhite,
//                                           fontWeight: FontWeight.w600)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               if (Appdata.isFromSlider) {
//                               } else {
//                                 Navigator.pop(context);
//                                 NavRouter.pop(context);
//                                 NavRouter.pop(context);
//                                 NavRouter.pop(context);
//                                 NavRouter.pop(context);
//                                 NavRouter.pop(context);
//                                 NavRouter.pushReplacement(
//                                     context, ReusableVideoListPage());
//                               }
//                             },
//                             icon: Icon(Icons.close, color: AppColors.pureWhite))
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     if (script != null)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 16),
//                           Text(
//                             "Read Below Script",
//                             style: TextStyles.regularTextStyle(
//                                 textColor: Color(0xFF49eae4), fontSize: 12),
//                           ),
//                           const SizedBox(height: 5),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width,
//                             child: Text(
//                               script!,
//                               style: TextStyles.mediumTextStyle(
//                                   textColor: AppColors.pureWhite, fontSize: 17),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               )),
//           Positioned(
//               bottom: 60,
//               child: Column(
//                 children: [
//                   lights == true
//                       ? Text("Lights ",
//                           style: TextStyles.mediumTextStyle(
//                               textColor: AppColors.pureWhite, fontSize: 35))
//                       : camera == true
//                           ? Text("Camera ",
//                               style: TextStyles.mediumTextStyle(
//                                   textColor: AppColors.pureWhite, fontSize: 35))
//                           : action == true
//                               ? Text("Action! ",
//                                   style: TextStyles.mediumTextStyle(
//                                       textColor: AppColors.pureWhite,
//                                       fontSize: 35))
//                               : isRecording == true
//                                   ? Text(
//                                       _count < 10
//                                           ? '00:0$_count'
//                                           : '00:$_count',
//                                       style: TextStyles.mediumTextStyle(
//                                           textColor: AppColors.pureWhite,
//                                           fontSize: 35))
//                                   : Container(
//                                       width: 162,
//                                       height: 40,
//                                       child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             primary:
//                                                 AppColors.black.withOpacity(.4),
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(30),
//                                                 side: BorderSide(
//                                                   width: 0.0,
//                                                   color: AppColors.black
//                                                       .withOpacity(.45),
//                                                 ))),
//                                         onPressed: () {
//                                           showDataAlert(context).then((value) {
//                                             setState(() {
//                                               script = value;
//                                             });
//                                           });
//                                         },
//                                         child: Row(
//                                           children: [
//                                             Icon(Icons.add,
//                                                 color: AppColors.warning),
//                                             SizedBox(width: 3),
//                                             Text(
//                                                 script != null &&
//                                                         script!.isNotEmpty
//                                                     ? 'Edit Script'
//                                                     : "Add Script",
//                                                 style:
//                                                     TextStyles.regularTextStyle(
//                                                         fontSize: 14,
//                                                         textColor:
//                                                             AppColors.warning)),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                   SizedBox(height: 15),
//                   secondsText == true
//                       ? Text(
//                           "Answer for at least 20 seconds",
//                           style: TextStyles.regularTextStyle(
//                               textColor: AppColors.pureWhite, fontSize: 13),
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
//                                     Appdata.videoList[4] = file.path;
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
//                                               index: 4,
//                                               question: question,
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
//
//   int _selectedIndex = -1;
//   Future<void> EditAndUpdateQuestion(BuildContext context) {
//     return showModalBottomSheet<void>(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(25),
//         ),
//       ),
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (BuildContext context,
//             StateSetter setState /*You can rename this!*/) {
//           return FractionallySizedBox(
//             heightFactor: .8,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Edit & Update Question",
//                     style: TextStyles.boldTextStyle(
//                         textColor: AppColors.black, fontSize: 24),
//                   ),
//                   SizedBox(height: 15),
//                   TextField(
//                     maxLines: 5,
//                     controller: questionController,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(top: 25, left: 10),
//                       enabledBorder: new OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: new BorderSide(
//                               color: Color(0xFFE7E4E5), width: 2)),
//                       focusedBorder: new OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: new BorderSide(
//                               color: Color(0xFFE7E4E5), width: 2)),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Or, you can select from recommended questions:",
//                     style: TextStyles.mediumTextStyle(fontSize: 15),
//                   ),
//                   SizedBox(height: 15),
//                   ListView(
//                     shrinkWrap: true,
//                     children: List.generate(Appdata.recommendedQuestions.length,
//                         (index) {
//                       // _selectedIndex = index;
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 15.0),
//                               child: GestureDetector(
//                                 behavior: HitTestBehavior.opaque,
//                                 onTap: () {
//                                   _selectedIndex = index;
//                                   if (_selectedIndex == index) {
//                                     questionController.text = Appdata
//                                         .recommendedQuestions[index].question;
//                                     question = Appdata
//                                         .recommendedQuestions[index].question;
//                                   }
//                                   setState(() {});
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Text(Appdata
//                                           .recommendedQuestions[index]
//                                           .question),
//                                     ),
//                                     Container(
//                                       height: 20,
//                                       width: 20,
//                                       decoration: BoxDecoration(
//                                           color: _selectedIndex == index
//                                               ? AppColors.acmeBlue
//                                               : AppColors.pureWhite,
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           border: Border.all(
//                                               color: _selectedIndex == index
//                                                   ? AppColors.acmeBlue
//                                                   : Colors.grey,
//                                               width: 1.5)),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Divider(height: 1, color: AppColors.moon),
//                         ],
//                       );
//                     }),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }
