// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../core/data/video_data.dart';
// import '../../../../reusable_video_list/reusable_video_list_controller.dart';
// import '../../../model/carousel_model.dart';
// import '../new_add_video_bot/slider_video_player/idle_video_module/add_idle_video.dart';
// import '../new_add_video_bot/slider_video_player/intro_video_module/add_intro_video_screen_2.dart';
// import '../new_add_video_bot/slider_video_player/question_one_video_module/question_1_video_screen.dart';
// import '../new_add_video_bot/slider_video_player/question_three_video_module/question_3_video_screen.dart';
// import '../new_add_video_bot/slider_video_player/question_two_video_module/question_2_video_screen.dart';
// import '../new_add_video_bot/slider_video_player/unrelated_video_module/unrelated_question_screen2.dart';
//
// class VideoSliderWidget extends StatefulWidget {
//   final List<VideoListData> videoListData;
//   final int index;
//   final ReusableVideoListController? videoListController;
//   final Function? canBuildVideo;
//
//   const VideoSliderWidget(
//       {Key? key,
//       required this.videoListData,
//       required this.index,
//       this.videoListController,
//       this.canBuildVideo})
//       : super(key: key);
//
//   @override
//   _VideoSliderWidgetState createState() => _VideoSliderWidgetState();
// }
//
// class _VideoSliderWidgetState extends State<VideoSliderWidget> {
//   BetterPlayerController? _betterPlayerController;
//   bool isVideoFinished = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!VideoModule.dataList.asMap().containsKey(widget.index)) {
//       if (widget.index == 0) {
//         return const AddIdleVideo();
//       } else if (widget.index == 1) {
//         return const AddIntroVideoScreen2();
//       } else if (widget.index == 2) {
//         return const AddUnrelatedQuestionVideo2();
//       } else if (widget.index == 3) {
//         return const QuestionOneVideoScreen();
//       } else if (widget.index == 4) {
//         return const QuestionTwoVideoScreen();
//       } else if (widget.index == 5) {
//         return const QuestionThreeVideoScreen();
//       }
//     } else {
//       return FractionallySizedBox(
//         widthFactor: 1,
//         heightFactor: .95,
//         // child: ReusableVideoListWidget(
//         //   videoListController: widget.videoListController,
//         //   canBuildVideo: widget.canBuildVideo,
//         //   videoListData: widget.videoListData[widget.index],
//         // ),
//         // Stack(
//         //   children: [
//         //     if (widget.dataList.asMap().containsKey(widget.index) &&
//         //         _betterPlayerController != null)
//         //       BetterPlayer(controller: _betterPlayerController!),
//         //     Center(
//         //       child: ButtonTheme(
//         //           height: 90.0,
//         //           minWidth: 90.0,
//         //           child: AnimatedOpacity(
//         //             opacity: isClicked ? 0.0 : 1.0,
//         //             duration: Duration(milliseconds: 2000),
//         //             child: RaisedButton(
//         //               padding: EdgeInsets.all(0.0),
//         //               color: Colors.transparent,
//         //               textColor: Colors.white,
//         //               onPressed: () {
//         //                 isClicked = !isClicked;
//         //                 if (_betterPlayerController!.isPlaying() == true) {
//         //                   _betterPlayerController!.pause();
//         //                 } else {
//         //                   _betterPlayerController!.play();
//         //                 }
//         //                 setState(() {});
//         //               },
//         //               child: Icon(
//         //                 _betterPlayerController!.isPlaying() == true
//         //                     ? Icons.pause
//         //                     : isVideoFinished == true
//         //                         ? Icons.play_arrow
//         //                         : Icons.play_arrow,
//         //                 size: 80.0,
//         //               ),
//         //             ),
//         //           )),
//         //     )
//         //   ],
//
//         // ),
//       );
//     }
//     return Container();
//   }
// }
