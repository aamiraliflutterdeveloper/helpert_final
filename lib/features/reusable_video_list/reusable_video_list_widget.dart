// import 'dart:async';
//
// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/constants/text_styles.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
// import 'package:helpert_app/features/reusable_video_list/reusable_video_list_controller.dart';
// import 'package:visibility_detector/visibility_detector.dart';
//
// import '../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/idle_video_module/add_idle_video.dart';
// import '../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/intro_video_module/add_intro_video_screen_2.dart';
// import '../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_one_video_module/question_1_video_screen.dart';
// import '../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_three_video_module/question_3_video_screen.dart';
// import '../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_two_video_module/question_2_video_screen.dart';
// import '../video/manage_video_bots/screens/new_add_video_bot/slider_video_player/unrelated_video_module/unrelated_question_screen2.dart';
// import '../video/model/carousel_model.dart';
//
// class ReusableVideoListWidget extends StatefulWidget {
//   final VideoListData videoListData;
//   final ReusableVideoListController? videoListController;
//   final Function? canBuildVideo;
//   final int index;
//   final bool active;
//
//   const ReusableVideoListWidget({
//     Key? key,
//     required this.videoListData,
//     required this.index,
//     this.videoListController,
//     this.canBuildVideo,
//     required this.active,
//   }) : super(key: key);
//
//   @override
//   _ReusableVideoListWidgetState createState() =>
//       _ReusableVideoListWidgetState();
// }
//
// class _ReusableVideoListWidgetState extends State<ReusableVideoListWidget> {
//   VideoListData? get videoListData => widget.videoListData;
//   BetterPlayerController? controller;
//   StreamController<BetterPlayerController?>
//       betterPlayerControllerStreamController = StreamController.broadcast();
//   bool _initialized = false;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     betterPlayerControllerStreamController.close();
//     super.dispose();
//   }
//
//   void _setupController() {
//     if (controller == null) {
//       controller = widget.videoListController!.getBetterPlayerController();
//       if (controller != null) {
//         controller!.setupDataSource(BetterPlayerDataSource.file(
//             videoListData!.videoUrl,
//             cacheConfiguration:
//                 BetterPlayerCacheConfiguration(useCache: true)));
//         if (!betterPlayerControllerStreamController.isClosed) {
//           betterPlayerControllerStreamController.add(controller);
//         }
//         controller!.addEventsListener(onPlayerEvent);
//       }
//     }
//   }
//
//   void _freeController() {
//     if (!_initialized) {
//       _initialized = true;
//       return;
//     }
//     if (controller != null && _initialized) {
//       controller!.removeEventsListener(onPlayerEvent);
//       widget.videoListController!.freeBetterPlayerController(controller);
//       controller!.pause();
//       controller = null;
//       if (!betterPlayerControllerStreamController.isClosed) {
//         betterPlayerControllerStreamController.add(null);
//       }
//       _initialized = false;
//     }
//   }
//
//   void onPlayerEvent(BetterPlayerEvent event) {
//     if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
//       videoListData!.lastPosition = event.parameters!["progress"] as Duration?;
//     }
//     if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
//       if (videoListData!.lastPosition != null) {
//         controller!.seekTo(videoListData!.lastPosition!);
//       }
//       if (videoListData!.wasPlaying!) {
//         controller!.play();
//       }
//     }
//   }
//
//   bool isClicked = false;
//   bool isVideoFinished = false;
//
//   Widget getScreen(int index) {
//     Widget widget = Container(child: Text('Empty widget :: $index'));
//     if (index == 0) {
//       return const AddIdleVideo();
//     } else if (index == 1) {
//       return const AddIntroVideoScreen2();
//     } else if (index == 2) {
//       return const AddUnrelatedQuestionVideo2();
//     } else if (index == 3) {
//       return const QuestionOneVideoScreen();
//     } else if (index == 4) {
//       return const QuestionTwoVideoScreen();
//     }
//     return const QuestionThreeVideoScreen();
//   }
//
//   String getTitle(int index) {
//     if (index == 0) {
//       return 'Idle video';
//     } else if (index == 1) {
//       return 'Introduce Yourself';
//     } else if (index == 2) {
//       return 'Answer for unrelated questions';
//     } else if (index == 3) {
//       return 'What research did you do about 10,000 startups before sending in your job application?';
//     } else if (index == 4) {
//       return 'What are your top 3 preparation tips for landing a job at 10,000 startups?';
//     }
//     return 'Can you brief us about your business';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double blur = widget.active ? 30 : 0;
//     final double offset = widget.active ? 20 : 0;
//     final double top = widget.active ? 20 : 60;
//     final double bottom = widget.active ? 20 : 60;
//     for (int i = 0; i < Appdata.videoList.length; i++) {}
//     return widget.videoListData.videoUrl.isEmpty
//         ? AnimatedContainer(
//             duration: Duration(milliseconds: 500),
//             curve: Curves.easeOutQuint,
//             margin: EdgeInsets.only(top: top, bottom: bottom),
//             child: getScreen(widget.index))
//         : AnimatedContainer(
//             duration: Duration(milliseconds: 500),
//             curve: Curves.easeOutQuint,
//             margin: EdgeInsets.only(top: top, bottom: bottom),
//             child: VisibilityDetector(
//               key: Key(hashCode.toString() + DateTime.now().toString()),
//               onVisibilityChanged: (info) {
//                 if (!widget.canBuildVideo!()) {
//                   _timer?.cancel();
//                   _timer = null;
//                   _timer = Timer(Duration(milliseconds: 500), () {
//                     if (info.visibleFraction >= 0.6) {
//                       _setupController();
//                     } else {
//                       _freeController();
//                     }
//                   });
//                   return;
//                 }
//                 if (info.visibleFraction >= 0.6) {
//                   _setupController();
//                 } else {
//                   _freeController();
//                 }
//               },
//               child: StreamBuilder<BetterPlayerController?>(
//                 stream: betterPlayerControllerStreamController.stream,
//                 builder: (context, snapshot) {
//                   return Container(
//                     decoration: BoxDecoration(
//                         color: AppColors.pureWhite,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Stack(
//                       children: [
//                         controller != null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: BetterPlayer(
//                                   controller: controller!,
//                                 ),
//                               )
//                             : Container(
//                                 height: double.infinity,
//                                 decoration: BoxDecoration(
//                                     color: AppColors.black,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Center(
//                                   child: CircularProgressIndicator(
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white),
//                                   ),
//                                 ),
//                               ),
//                         if (controller != null)
//                           Positioned(
//                               top: 20,
//                               left: 20,
//                               right: 20,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(getTitle(widget.index),
//                                         style: TextStyles.boldTextStyle(
//                                             textColor: AppColors.pureWhite)),
//                                   ),
//                                   Container(
//                                     width: 30,
//                                     height: 30,
//                                     decoration: BoxDecoration(
//                                         color: AppColors.success,
//                                         shape: BoxShape.circle),
//                                     child: Icon(
//                                       Icons.check,
//                                       size: 18,
//                                       color: AppColors.pureWhite,
//                                     ),
//                                   )
//                                 ],
//                               )),
//                         if (controller != null)
//                           Center(
//                             child: ButtonTheme(
//                                 height: 90.0,
//                                 minWidth: 90.0,
//                                 child: AnimatedOpacity(
//                                   opacity: isClicked ? 0.0 : 1.0,
//                                   duration: Duration(milliseconds: 2000),
//                                   child: RaisedButton(
//                                     padding: EdgeInsets.all(0.0),
//                                     color: Colors.transparent,
//                                     textColor: Colors.white,
//                                     onPressed: () {
//                                       isClicked = !isClicked;
//                                       if (controller!.isPlaying() == true) {
//                                         controller!.pause();
//                                       } else {
//                                         controller!.play();
//                                       }
//                                       controller!.addEventsListener((p0) {
//                                         if (p0.betterPlayerEventType ==
//                                             BetterPlayerEventType.finished) {
//                                           isVideoFinished = true;
//                                         }
//                                       });
//                                       setState(() {});
//                                     },
//                                     child: Icon(
//                                       controller!.isPlaying() == true
//                                           ? Icons.pause
//                                           : isVideoFinished == true
//                                               ? Icons.play_arrow
//                                               : Icons.play_arrow,
//                                       size: 80.0,
//                                     ),
//                                   ),
//                                 )),
//                           )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//   }
//
//   @override
//   void deactivate() {
//     if (controller != null) {
//       videoListData!.wasPlaying = controller!.isPlaying();
//     }
//     _initialized = true;
//     super.deactivate();
//   }
// }
