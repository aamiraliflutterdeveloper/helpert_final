// import 'package:better_player/better_player.dart';
// import 'package:collection/collection.dart' show IterableExtension;
// import 'package:flutter/material.dart';
//
// class ReusableVideoListController {
//   final List<BetterPlayerController> _betterPlayerControllerRegistry = [];
//   final List<BetterPlayerController> _usedBetterPlayerControllerRegistry = [];
//
//   BetterPlayerConfiguration betterPlayerConfiguration =
//       BetterPlayerConfiguration(
//     autoDetectFullscreenDeviceOrientation: true,
//     autoDetectFullscreenAspectRatio: true,
//     // controlsConfiguration: controlsConfiguration,
//     fit: BoxFit.cover,
//     controlsConfiguration: BetterPlayerControlsConfiguration(
//         controlBarColor: Colors.transparent,
//         enablePip: false,
//         iconsColor: Colors.white,
//         progressBarPlayedColor: Colors.indigo,
//         progressBarHandleColor: Colors.indigo,
//         enableQualities: false,
//         enablePlayPause: false,
//         loadingColor: Colors.red,
//         overflowModalColor: Colors.black54,
//         overflowModalTextColor: Colors.white,
//         enableProgressBar: false,
//         enableProgressText: false,
//         textColor: Colors.red,
//         liveTextColor: Colors.blue,
//         enableProgressBarDrag: false,
//         enableFullscreen: true,
//         enableSubtitles: false,
//         controlBarHeight: 0,
//         progressBarBackgroundColor: Colors.transparent,
//         pauseIcon: Icons.pause,
//         playIcon: Icons.play_arrow,
//         enableSkips: false,
//         enableOverflowMenu: false,
//         showControls: false,
//         showControlsOnInitialize: true),
//     aspectRatio: .4,
//     allowedScreenSleep: false,
//     autoDispose: false,
//     handleLifecycle: false,
//     eventListener: (value) {
//       if (value.betterPlayerEventType == BetterPlayerEventType.finished) {
//         // isVideoFinished = true;
//         // isClicked = !isClicked;
//         // setState(() {});
//       }
//     },
//     autoPlay: false,
//   );
//
//   ReusableVideoListController() {
//     for (int index = 0; index < 3; index++) {
//       _betterPlayerControllerRegistry.add(
//         BetterPlayerController(betterPlayerConfiguration),
//       );
//     }
//   }
//
//   BetterPlayerController? getBetterPlayerController() {
//     final freeController = _betterPlayerControllerRegistry.firstWhereOrNull(
//         (controller) =>
//             !_usedBetterPlayerControllerRegistry.contains(controller));
//
//     if (freeController != null) {
//       _usedBetterPlayerControllerRegistry.add(freeController);
//     }
//
//     return freeController;
//   }
//
//   void freeBetterPlayerController(
//       BetterPlayerController? betterPlayerController) {
//     _usedBetterPlayerControllerRegistry.remove(betterPlayerController);
//   }
//
//   void dispose() {
//     _betterPlayerControllerRegistry.forEach((controller) {
//       controller.dispose();
//     });
//   }
// }
