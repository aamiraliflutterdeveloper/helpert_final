// import 'package:better_player/better_player.dart';
// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:helpert_app/common_widgets/bottons/elevated_button_without_icon.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
// import 'package:helpert_app/features/video/bloc/video/video_bloc.dart';
// import 'package:helpert_app/features/video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_one_video_module/question_one_video_rec_screen.dart';
// import 'package:helpert_app/features/video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_three_video_module/question_three_video_rec_screen.dart';
// import 'package:helpert_app/features/video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_two_video_module/question_two_video_rec_screen.dart';
//
// import '../../../../../../../core/data/video_data.dart';
// import '../../../../../../../utils/nav_router.dart';
// import '../../../../../../reusable_video_list/reusable_video_list_page.dart';
// import '../../../../../bloc/video/video_state.dart';
// import '../../../../../model/carousel_model.dart';
// import '../intro_video_module/intro_video_rec_screen.dart';
// import '../unrelated_video_module/unrelated_question_record_screen.dart';
//
// class RecordedVideoViewScreen extends StatefulWidget {
//   final int index;
//   final String? question;
//   // final XFile file;
//
//   const RecordedVideoViewScreen({Key? key, required this.index, this.question})
//       : super(key: key);
//
//   @override
//   State<RecordedVideoViewScreen> createState() =>
//       _RecordedVideoViewScreenState();
// }
//
// class _RecordedVideoViewScreenState extends State<RecordedVideoViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RecordedVideoWidgetView(
//         question: widget.question,
//         index: widget.index,
//       ),
//     );
//   }
// }
//
// class RecordedVideoWidgetView extends StatefulWidget {
//   final String? question;
//   final int index;
//
//   const RecordedVideoWidgetView({Key? key, required this.index, this.question})
//       : super(key: key);
//
//   @override
//   _RecordedVideoWidgetViewState createState() =>
//       _RecordedVideoWidgetViewState();
// }
//
// class _RecordedVideoWidgetViewState extends State<RecordedVideoWidgetView> {
//   BetterPlayerController? _betterPlayerController;
//   bool isVideoFinished = false;
//
//   @override
//   void initState() {
//     super.initState();
//     playVideo();
//   }
//
//   playVideo() {
//     // if (mounted && _betterPlayerController != null) {
//     //   setState(() {
//     //     _betterPlayerController = null;
//     //   });
//     // }
//     BetterPlayerConfiguration betterPlayerConfiguration =
//         BetterPlayerConfiguration(
//       autoDetectFullscreenDeviceOrientation: true,
//       autoDetectFullscreenAspectRatio: true,
//       controlsConfiguration: controlsConfiguration,
//       fit: BoxFit.cover,
//       autoDispose: false,
//       aspectRatio: .49,
//       allowedScreenSleep: false,
//       eventListener: (value) {
//         if (value.betterPlayerEventType == BetterPlayerEventType.finished) {
//           isVideoFinished = true;
//           isClicked = !isClicked;
//           setState(() {});
//         }
//       },
//       autoPlay: false,
//     );
//     BetterPlayerDataSource dataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.file, Appdata.videoList[widget.index]);
//     _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
//     _betterPlayerController!.setupDataSource(dataSource);
//   }
//
//   bool isClicked = false;
//   BetterPlayerControlsConfiguration controlsConfiguration =
//       const BetterPlayerControlsConfiguration(
//           controlBarColor: Colors.transparent,
//           enablePip: false,
//           iconsColor: Colors.white,
//           progressBarPlayedColor: Colors.indigo,
//           progressBarHandleColor: Colors.indigo,
//           enableQualities: false,
//           enablePlayPause: false,
//           loadingColor: Colors.red,
//           overflowModalColor: Colors.black54,
//           overflowModalTextColor: Colors.white,
//           enableProgressBar: false,
//           enableProgressText: false,
//           textColor: Colors.red,
//           liveTextColor: Colors.blue,
//           enableProgressBarDrag: false,
//           enableFullscreen: true,
//           enableSubtitles: false,
//           controlBarHeight: 0,
//           progressBarBackgroundColor: Colors.transparent,
//           pauseIcon: Icons.pause,
//           playIcon: Icons.play_arrow,
//           enableSkips: false,
//           enableOverflowMenu: false,
//           showControls: false,
//           showControlsOnInitialize: true);
//
//   @override
//   void dispose() {
//     if (_betterPlayerController != null) {
//       _betterPlayerController!.dispose(forceDispose: true);
//       _betterPlayerController = null;
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FractionallySizedBox(
//       widthFactor: 1,
//       heightFactor: 1,
//       child: Stack(
//         children: [
//           if (_betterPlayerController != null)
//             BetterPlayer(controller: _betterPlayerController!),
//           Positioned(
//               top: 40,
//               left: 10,
//               right: 10,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         // NavRouter.pushReplacement(
//                         //     context, ReusableVideoListPage());
//                         NavRouter.pop(context);
//                       },
//                       child: Container(
//                         height: 25,
//                         width: 25,
//                         decoration: BoxDecoration(
//                             color: AppColors.moon,
//                             borderRadius: BorderRadius.circular(30)),
//                         child: Icon(Icons.cancel_rounded,
//                             color: AppColors.pureWhite),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 120,
//                         child: ElevatedButtonWithoutIcon(
//                           text: 'Retake',
//                           onPressed: () {
//                             Navigator.pop(context);
//                             // Navigator.pop(context);
//                           },
//                           textColor: AppColors.pureWhite,
//                           height: 40,
//                           borderRadius: 40,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Container(
//                         width: 100,
//                         child: BlocConsumer<VideoBloc, VideoState>(
//                           listener: (context, state) {
//                             if (state is VideoLoading) {
//                               BotToast.showLoading();
//                             }
//                             if (state is VideoLoaded) {
//                               BotToast.closeAllLoading();
//                               // Navigator.pop(context);
//                               // Navigator.pop(context);
//                               // Navigator.pop(context);
//                               if (Appdata.isFromSlider) {
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                                 NavRouter.pushReplacement(
//                                     context, ReusableVideoListPage());
//                               } else {
//                                 if (widget.index == 1) {
//                                   NavRouter.pushReplacement(
//                                       context, UnrelatedQuestionRecScreen());
//                                 } else if (widget.index == 2) {
//                                   NavRouter.pushReplacement(
//                                       context, QuestionOneVideoRecordScreen());
//                                 } else if (widget.index == 3) {
//                                   NavRouter.pushReplacement(
//                                       context, QuestionTwoVideoRecordScreen());
//                                 } else if (widget.index == 4) {
//                                   NavRouter.pushReplacement(context,
//                                       QuestionThreeVideoRecordScreen());
//                                 } else {
//                                   NavRouter.pushReplacement(
//                                       context, ReusableVideoListPage());
//                                 }
//                               }
//
//                               // NavRouter.push(context, ReusableVideoListPage());
//                               // Navigator.of(context)
//                               //     .popUntil((route) => route.isFirst);
//                               // clearVideoModuleLists();
//                               // VideoModule.topic.clear();
//                               // VideoModule.introVideo.clear();
//                               // VideoModule.videoQuestions.clear();
//                             }
//                             if (state is VideoError) {
//                               BotToast.closeAllLoading();
//                               BotToast.showText(text: state.error);
//                             }
//                           },
//                           builder: (context, state) {
//                             return ElevatedButtonWithoutIcon(
//                               text: 'Upload',
//                               onPressed: () {
//                                 // VideoModule.dataList.add(VideoListData(
//                                 //     '${widget.index}', widget.file.path));
//                                 if (widget.index == 0) {
//                                   // dataList
//                                   VideoModule.dataList.insert(
//                                       0,
//                                       VideoListData(
//                                           "Video 0", Appdata.videoList[0]));
//                                 } else if (widget.index == 1 &&
//                                     VideoModule.dataList
//                                         .asMap()
//                                         .containsKey(widget.index - 1)) {
//                                   VideoModule.introVideo
//                                       .add(Appdata.videoList[1]);
//                                   VideoModule.dataList.insert(
//                                       1,
//                                       VideoListData(
//                                           "Video 0", Appdata.videoList[1]));
//                                 } else if (widget.index == 2 &&
//                                     VideoModule.dataList
//                                         .asMap()
//                                         .containsKey(widget.index - 1)) {
//                                   VideoModule.defaultVideo
//                                       .add(Appdata.videoList[2]);
//                                   VideoModule.dataList.insert(
//                                       2,
//                                       VideoListData(
//                                           "Video 0", Appdata.videoList[2]));
//                                 } else if (widget.index == 3 &&
//                                     VideoModule.dataList
//                                         .asMap()
//                                         .containsKey(widget.index - 1)) {
//                                   /// first clear
//                                   VideoModule.videoList.clear();
//                                   VideoModule.videoQuestions.clear();
//                                   VideoModule.questionPublish
//                                       .add(widget.question!);
//
//                                   /// add new values ...
//                                   VideoModule.videoList
//                                       .add(Appdata.videoList[3]);
//                                   VideoModule.videoQuestions
//                                       .add(widget.question!);
//                                   VideoModule.dataList.insert(
//                                       3,
//                                       VideoListData(
//                                           "Video 0", Appdata.videoList[3]));
//                                 } else if (widget.index == 4 &&
//                                     VideoModule.dataList
//                                         .asMap()
//                                         .containsKey(widget.index - 1)) {
//                                   /// first clear
//                                   VideoModule.videoList.clear();
//                                   VideoModule.videoQuestions.clear();
//                                   VideoModule.questionPublish
//                                       .add(widget.question!);
//
//                                   /// add new values ...
//                                   VideoModule.videoList
//                                       .add(Appdata.videoList[4]);
//                                   VideoModule.videoQuestions
//                                       .add(widget.question!);
//                                   VideoModule.dataList.insert(
//                                       4,
//                                       VideoListData(
//                                           "Video 0", Appdata.videoList[4]));
//                                 } else if (widget.index == 5 &&
//                                     VideoModule.dataList
//                                         .asMap()
//                                         .containsKey(widget.index - 1)) {
//                                   /// first clear
//                                   VideoModule.videoList.clear();
//                                   VideoModule.videoQuestions.clear();
//                                   VideoModule.questionPublish
//                                       .add(widget.question!);
//
//                                   /// add new values ...
//                                   VideoModule.videoList
//                                       .add(Appdata.videoList[5]);
//                                   VideoModule.videoQuestions
//                                       .add(widget.question!);
//                                   VideoModule.dataList.insert(
//                                       5,
//                                       VideoListData(
//                                           "Video 0", Appdata.videoList[5]));
//                                 } else {
//                                   BotToast.showText(
//                                       text:
//                                           'Please record previous video first');
//                                 }
//                                 // Navigator.pop(context);
//                                 // Navigator.pop(context);
//                                 // Navigator.pop(context);
//                                 // Navigator.pop(context);
//
//                                 if (widget.index == 0) {
//                                   // Navigator.pop(context);
//                                   //Navigator.pop(context);
//                                   // Navigator.pop(context);
//                                   // Navigator.pop(context);
//                                   NavRouter.pushReplacement(
//                                       context, IntroVideoRecScreen());
//                                 } else {
//                                   if (VideoModule.dataList
//                                       .asMap()
//                                       .containsKey(widget.index)) {
//                                     context.read<VideoBloc>().publishVideo(
//                                           (widget.index == 1)
//                                               ? VideoModule.categoryList[0]
//                                               : null,
//                                           (widget.index == 1)
//                                               ? VideoModule.introVideo[0]
//                                               : null,
//                                           (widget.index == 2)
//                                               ? VideoModule.defaultVideo[0]
//                                               : null,
//                                           (widget.index == 3)
//                                               ? VideoModule.videoList[0]
//                                               : (widget.index == 4)
//                                                   ? VideoModule.videoList[0]
//                                                   : (widget.index == 5)
//                                                       ? VideoModule.videoList[0]
//                                                       : null,
//                                           (widget.index == 3)
//                                               ? VideoModule.videoQuestions[0]
//                                               : (widget.index == 4)
//                                                   ? VideoModule
//                                                       .videoQuestions[0]
//                                                   : (widget.index == 5)
//                                                       ? VideoModule
//                                                           .videoQuestions[0]
//                                                       : null,
//                                           (widget.index == 1)
//                                               ? VideoModule.topic[0]
//                                               : null,
//                                         );
//                                   }
//                                 }
//                               },
//                               textColor: AppColors.pureWhite,
//                               height: 40,
//                               borderRadius: 40,
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               )),
//           Center(
//             child: ButtonTheme(
//                 height: 90.0,
//                 minWidth: 90.0,
//                 child: AnimatedOpacity(
//                   opacity: isClicked ? 0.0 : 1.0,
//                   duration: Duration(milliseconds: 2000),
//                   child: RaisedButton(
//                     padding: EdgeInsets.all(0.0),
//                     color: Colors.transparent,
//                     textColor: Colors.white,
//                     onPressed: () {
//                       isClicked = !isClicked;
//                       if (_betterPlayerController!.isPlaying() == true) {
//                         _betterPlayerController!.pause();
//                       } else {
//                         _betterPlayerController!.play();
//                       }
//                       setState(() {});
//                     },
//                     child: Icon(
//                       _betterPlayerController!.isPlaying() == true
//                           ? Icons.pause
//                           : isVideoFinished == true
//                               ? Icons.play_arrow
//                               : Icons.play_arrow,
//                       size: 80.0,
//                     ),
//                   ),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }
