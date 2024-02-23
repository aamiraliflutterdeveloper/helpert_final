import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:video_compress/video_compress.dart';

import '../../../constants/asset_paths.dart';
import '../screens/new_video_view_screen.dart';
import 'count_down_timer.dart';

class NewCameraWidget extends StatefulWidget {
  final CameraController cameraController;
  final GestureTapCallback? callBack;
  final GestureTapCallback? flashCallBack;

  const NewCameraWidget(
      {Key? key,
      this.callBack,
      required this.cameraController,
      this.flashCallBack})
      : super(key: key);

  @override
  State<NewCameraWidget> createState() => _NewCameraWidgetState();
}

class _NewCameraWidgetState extends State<NewCameraWidget>
    with TickerProviderStateMixin {
  List<int> timeList = [60, 30];
  int selectedTimerIndex = 1;
  late Timer _recordingTimer;
  int _count = 0;
  int timeLimit = 31;
  int _countDown = 31;
  bool isRecording = false;
  XFile? videoFile;
  MultipartFile? introThumbnail;

  @override
  initState() {
    super.initState();
    if (isRecording == true && mounted) {
      widget.cameraController.stopVideoRecording();
    }
  }

  AnimationController? _controller;
  int levelClock = 30;

  _startTime() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: _countDown));
    _controller!.forward();
  }

  void _startTimer() {
    _startTime();
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (mounted) {
        setState(() {
          if (_count < timeLimit) _count = _count + 1;
        });
        if (_count == timeList[selectedTimerIndex]) {
          if (isRecording == true) {
            await widget.cameraController
                .stopVideoRecording()
                .then((XFile? file) {
              if (file != null) {
                videoFile = file;
                isRecording = false;
                _count = 0;
                _recordingTimer.cancel();
                setState(() {});
              }
            });
            final thumbnailFile = await VideoCompress.getFileThumbnail(
                videoFile!.path,
                quality: 60,
                position: -1);
            String fileName = thumbnailFile.path.split('/').last;
            introThumbnail = await MultipartFile.fromFile(thumbnailFile.path,
                filename: fileName);
            if (introThumbnail == null) {
              BotToast.showLoading();
            } else {
              BotToast.closeAllLoading();
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewVideoViewScreen(
                          videoFile: videoFile,
                          introThumbnail: introThumbnail))).then((value) {
                if (mounted) {
                  setState(() {
                    isRecording = false;
                  });
                }
              });
            }
          }
          _recordingTimer.cancel();
        }
      }
    });
  }

  CameraController? cameraController;

  Future initCamera(CameraDescription cameraDescription) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);
    try {
      await cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException {
      debugPrint('');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    widget.cameraController.dispose();
    VideoCompress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          (widget.cameraController.value.isInitialized)
              ? Center(
                  child: Transform.scale(
                      scale: 1 /
                          (widget.cameraController.value.aspectRatio *
                              mediaSize.aspectRatio),
                      child: CameraPreview(widget.cameraController)))
              : Container(
                  color: Colors.black,
                  child: const Center(child: CircularProgressIndicator())),
          if (isRecording == true)
            Positioned(
              bottom: 165,
              left: 0,
              right: 0,
              child: Center(
                child: Countdown(
                  timeLimit: _countDown,
                  animation: StepTween(
                    begin: _countDown, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_controller!),
                ),
              ),
            ),
          if (isRecording == false)
            Positioned(
              bottom: 0,
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  color: AppColors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(timeList.length, (index) {
                            return Row(
                              children: [
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    selectedTimerIndex = index;
                                    int time = timeList[selectedTimerIndex];
                                    timeLimit = time + 1;
                                    _countDown = time + 1;
                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(timeList[index].toString(),
                                            style: TextStyles.mediumTextStyle(
                                                textColor:
                                                    selectedTimerIndex == index
                                                        ? AppColors.pureWhite
                                                        : AppColors.nickel)),
                                      ),
                                      SizedBox(height: 5),
                                      selectedTimerIndex == index
                                          ? CircleAvatar(
                                              radius: 2,
                                              backgroundColor:
                                                  AppColors.pureWhite)
                                          : SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            );
                          })),
                      SizedBox(height: 18),
                    ],
                  )),
            ),
          Positioned(
              bottom: 80,
              child: SizedBox(
                  child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onDoubleTap: null,
                      onTap: () async {
                        if (mounted && isRecording == false) {
                          isRecording = true;
                          // _startTime();
                          await widget.cameraController.startVideoRecording();
                          _startTimer();
                        } else if (mounted && isRecording == true) {
                          isRecording = false;
                          _count = 0;
                          _recordingTimer.cancel();
                          await widget.cameraController
                              .stopVideoRecording()
                              .then((XFile? file) {
                            if (file != null) {
                              setState(() {
                                videoFile = file;
                              });
                              // _startVideoPlayer();
                            }
                          });
                          final thumbnailFile =
                              await VideoCompress.getFileThumbnail(
                                  videoFile!.path,
                                  quality: 60,
                                  position: -1);
                          String fileName = thumbnailFile.path.split('/').last;
                          introThumbnail = await MultipartFile.fromFile(
                              thumbnailFile.path,
                              filename: fileName);
                          if (introThumbnail == null) {
                            BotToast.showLoading();
                          } else {
                            BotToast.closeAllLoading();
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewVideoViewScreen(
                                        videoFile: videoFile,
                                        introThumbnail: introThumbnail))).then(
                                (value) {
                              if (mounted) {
                                isRecording = false;
                              }
                              setState(() {});
                            });
                          }
                        }
                      },
                      child: Icon(
                        Icons.radio_button_on,
                        color: isRecording == true
                            ? AppColors.failure
                            : AppColors.pureWhite,
                        size: 80,
                      ),
                    ),
                  ),
                ),
              ))),
          if (isRecording == false)
            Positioned(
              top: 50,
              left: 10,
              child: CircleIconButton(),
            ),
          if (isRecording == false)
            Positioned(
                bottom: 320,
                right: 12,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: widget.callBack,
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          children: [
                            Image.asset(FlipIcon,
                                height: 22, width: 27, fit: BoxFit.cover),
                            SizedBox(height: 5),
                            Text(
                              "Flip",
                              style: TextStyles.regularTextStyle(
                                  textColor: AppColors.pureWhite, fontSize: 10),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: 20),
                      // Column(
                      //   children: [
                      //     Image.asset(FiltersIcon,
                      //         height: 23, width: 24, fit: BoxFit.cover),
                      //     SizedBox(height: 5),
                      //     Text("Filters",
                      //         style: TextStyles.regularTextStyle(
                      //             textColor: AppColors.pureWhite, fontSize: 10))
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // Column(
                      //   children: [
                      //     Image.asset(TimerIcon, width: 22, height: 24),
                      //     SizedBox(height: 5),
                      //     Text("Timer",
                      //         style: TextStyles.regularTextStyle(
                      //             textColor: AppColors.pureWhite, fontSize: 10))
                      //   ],
                      // ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: widget.flashCallBack,
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          children: [
                            Image.asset(flashIcon, width: 18, height: 24),
                            SizedBox(height: 5),
                            Text("Flash",
                                style: TextStyles.regularTextStyle(
                                    textColor: AppColors.pureWhite,
                                    fontSize: 10))
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
        ],
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const CircleIconButton({
    Key? key,
    this.color = AppColors.pureWhite,
    this.height = 56,
    this.width = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 10, bottom: 0),
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: AppColors.black.withOpacity(.6), // Splash color
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.only(left: 0),
                  alignment: Alignment.center,
                  width: width,
                  height: height,
                  child: Icon(Icons.close, color: color)),
            ),
          ),
        ));
  }
}
