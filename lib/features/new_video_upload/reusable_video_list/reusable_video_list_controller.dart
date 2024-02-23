// import 'package:better_player/better_player.dart';
// import 'package:collection/collection.dart' show IterableExtension;
// import 'package:flutter/cupertino.dart';
//
// class ReusableVideoListController {
//   final List<BetterPlayerController> _betterPlayerControllerRegistry = [];
//   final List<BetterPlayerController> _usedBetterPlayerControllerRegistry = [];
//
//   ReusableVideoListController() {
//     for (int index = 0; index < 3; index++) {
//       _betterPlayerControllerRegistry.add(BetterPlayerController(
//         BetterPlayerConfiguration(
//           handleLifecycle: false,
//           autoDispose: false,
//           autoDetectFullscreenAspectRatio: true,
//           expandToFill: true,
//           autoPlay: true,
//           looping: true,
//           translations: [],
//           aspectRatio: .48,
//           fit: BoxFit.cover,
//           placeholderOnTop: false,
//           controlsConfiguration: BetterPlayerControlsConfiguration(
//             enableRetry: true,
//             enablePip: false,
//             enableOverflowMenu: false,
//             enableFullscreen: false,
//             enableMute: false,
//             enableProgressText: false,
//             enableProgressBar: false,
//             enableProgressBarDrag: false,
//             enablePlayPause: false,
//             enableSkips: false,
//             enableAudioTracks: false,
//             enableSubtitles: false,
//             enableQualities: false,
//             enablePlaybackSpeed: false,
//           ),
//         ),
//       ));
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
