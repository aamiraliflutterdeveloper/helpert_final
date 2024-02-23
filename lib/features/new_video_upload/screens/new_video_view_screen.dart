import 'package:better_player/better_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../common_widgets/bottons/elevated_button_without_icon.dart';
import '../../../constants/app_colors.dart';
import '../widgets/new_camera_widget.dart';
import 'new_video_publish_screen.dart';

class NewVideoViewScreen extends StatefulWidget {
  final videoFile;
  final MultipartFile? introThumbnail;

  const NewVideoViewScreen({
    Key? key,
    required this.videoFile,
    this.introThumbnail,
  }) : super(key: key);

  @override
  State<NewVideoViewScreen> createState() => _NewVideoViewScreenState();
}

class _NewVideoViewScreenState extends State<NewVideoViewScreen> {
  BetterPlayerController? _betterPlayerController;
  BetterPlayerDataSource? _betterPlayerDataSource;
  BetterPlayerConfiguration? betterPlayerConfiguration;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    betterPlayerConfiguration = BetterPlayerConfiguration(
        autoDispose: true,
        looping: true,
        autoPlay: false,
        aspectRatio: .45,
        eventListener: (value) {
          if (value.betterPlayerEventType == BetterPlayerEventType.play ||
              value.betterPlayerEventType ==
                  BetterPlayerEventType.bufferingStart) {
            isPlaying = true;
            setState(() {});
          } else if (value.betterPlayerEventType ==
                  BetterPlayerEventType.pause ||
              value.betterPlayerEventType == BetterPlayerEventType.finished) {
            isPlaying = false;
            setState(() {});
          }
        },
        handleLifecycle: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableRetry: true,
          playIcon: Icons.play_arrow_sharp,
          playerTheme: BetterPlayerTheme.custom,
          enableOverflowMenu: false,
          enableFullscreen: false,
          enableMute: false,
          enableProgressText: false,
          enableProgressBar: false,
          enableProgressBarDrag: false,
          enablePlayPause: false,
          enableSkips: false,
          enableAudioTracks: false,
          enableSubtitles: false,
          enableQualities: false,
          enablePlaybackSpeed: false,
          overflowModalColor: Colors.transparent,
          overflowModalTextColor: Colors.white,
          overflowMenuIconsColor: Colors.white,
        ));
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      widget.videoFile.path,
    );
    _betterPlayerController =
        BetterPlayerController(betterPlayerConfiguration!);
    _betterPlayerController!.setupDataSource(_betterPlayerDataSource!);
  }

  @override
  void dispose() {
    // _betterPlayerController!.pause();
    // _betterPlayerController!.dispose();
    // betterPlayerConfiguration = null;
    // _betterPlayerDataSource = null;
    // _betterPlayerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BetterPlayer(controller: _betterPlayerController!),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                isPlaying
                    ? _betterPlayerController!.pause()
                    : _betterPlayerController!.play();
              },
              child: Align(
                child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.pureWhite),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                color: AppColors.black,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0) +
                      EdgeInsets.only(top: 3, bottom: 35),
                  child: ElevatedButtonWithoutIcon(
                    onPressed: () async {
                      // _betterPlayerController.dispose();
                      await NavRouter.pushReplacement(
                              context,
                              NewVideoPublishScreen(
                                  videoFile: widget.videoFile,
                                  introThumbnail: widget.introThumbnail))
                          .then((value) {});
                      // StatusBarStyles.darkStatusAndNavigationBar();
                    },
                    text: 'Next',
                  ),
                ),
              )),
          Positioned(
            top: 50,
            left: 10,
            child: CircleIconButton(),
          ),
        ],
      ),
    );
  }
}
