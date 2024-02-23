// import 'dart:async';
//
// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:visibility_detector/visibility_detector.dart';
//
// import '../../../../model/carousel_model.dart';
// import 'intro_video_module/add_intro_video_screen_2.dart';
// import 'reuseable_video_list_controller.dart';
//
// class ReusableVideoListWidget extends StatefulWidget {
//   final VideoListData videoListData;
//   final ReusableVideoListController? videoListController;
//   final Function? canBuildVideo;
//
//   const ReusableVideoListWidget({
//     Key? key,
//     required this.videoListData,
//     this.videoListController,
//     this.canBuildVideo,
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
//                 const BetterPlayerCacheConfiguration(useCache: true)));
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
//   @override
//   Widget build(BuildContext context) {
//     return widget.videoListData.videoUrl.isEmpty
//         ? AddIntroVideoScreen2()
//         : VisibilityDetector(
//             key: Key(hashCode.toString() + DateTime.now().toString()),
//             onVisibilityChanged: (info) {
//               if (!widget.canBuildVideo!()) {
//                 _timer?.cancel();
//                 _timer = null;
//                 _timer = Timer(const Duration(milliseconds: 500), () {
//                   if (info.visibleFraction >= 0.6) {
//                     _setupController();
//                   } else {
//                     _freeController();
//                   }
//                 });
//                 return;
//               }
//               if (info.visibleFraction >= 0.6) {
//                 _setupController();
//               } else {
//                 _freeController();
//               }
//             },
//             child: StreamBuilder<BetterPlayerController?>(
//               stream: betterPlayerControllerStreamController.stream,
//               builder: (context, snapshot) {
//                 return Stack(
//                   children: [
//                     controller != null
//                         ? BetterPlayer(
//                             controller: controller!,
//                           )
//                         : Container(
//                             height: double.infinity,
//                             color: Colors.black,
//                             child: const Center(
//                               child: CircularProgressIndicator(
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.white),
//                               ),
//                             ),
//                           ),
//                     if (controller != null)
//                       Center(
//                         child: ButtonTheme(
//                             height: 90.0,
//                             minWidth: 90.0,
//                             child: AnimatedOpacity(
//                               opacity: isClicked ? 0.0 : 1.0,
//                               duration: const Duration(milliseconds: 2000),
//                               child: RaisedButton(
//                                 padding: const EdgeInsets.all(0.0),
//                                 color: Colors.transparent,
//                                 textColor: Colors.white,
//                                 onPressed: () {
//                                   isClicked = !isClicked;
//                                   if (controller!.isPlaying() == true) {
//                                     controller!.pause();
//                                   } else {
//                                     controller!.play();
//                                   }
//                                   controller!.addEventsListener((p0) {
//                                     if (p0.betterPlayerEventType ==
//                                         BetterPlayerEventType.finished) {
//                                       isVideoFinished = true;
//                                     }
//                                   });
//                                   setState(() {});
//                                 },
//                                 child: Icon(
//                                   controller!.isPlaying() == true
//                                       ? Icons.pause
//                                       : isVideoFinished == true
//                                           ? Icons.play_arrow
//                                           : Icons.play_arrow,
//                                   size: 80.0,
//                                 ),
//                               ),
//                             )),
//                       )
//                   ],
//                 );
//               },
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
