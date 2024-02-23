import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoViewScreen extends StatefulWidget {
  final XFile file;
  const VideoViewScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  // VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.file(File(widget.file.path))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    // _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: SafeArea(
      //   child: SizedBox(
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //     child: Stack(
      //       children: [
      //         SizedBox(
      //             width: MediaQuery.of(context).size.width,
      //             height: MediaQuery.of(context).size.height - 150,
      //             child: _controller!.value.isInitialized
      //                 ? AspectRatio(
      //                     aspectRatio: 16 / 9,
      //                     child: VideoPlayer(_controller!),
      //                   )
      //                 : Container()),
      //         Positioned(
      //             top: 10,
      //             left: 10,
      //             child: GestureDetector(
      //                 onTap: () {
      //                   Navigator.pop(context);
      //                   Navigator.pop(context);
      //                   Navigator.pop(context);
      //                   // showDialog(
      //                   //     barrierDismissible: false,
      //                   //     context: context,
      //                   //     builder: (BuildContext context) {
      //                   //       return CustomAlertDialog(
      //                   //           noPressed: () {
      //                   //             NavRouter.pop(context);
      //                   //           },
      //                   //           yesPressed: () {
      //                   //             clearVideoModuleLists();
      //                   //             Navigator.of(context)
      //                   //                 .popUntil((route) => route.isFirst);
      //                   //           },
      //                   //           title:
      //                   //               'Are you sure you want to discard all changes');
      //                   //     });
      //                 },
      //                 child: Icon(Icons.cancel, color: AppColors.pureWhite))),
      //         Positioned(
      //             bottom: 25,
      //             left: 0,
      //             right: 0,
      //             child: Container(
      //               width: MediaQuery.of(context).size.width,
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //                 child: Row(
      //                   children: [
      //                     Expanded(
      //                         child: ElevatedButtonWithoutIcon(
      //                             primaryColor: AppColors.success,
      //                             borderColor: AppColors.success,
      //                             text: 'Retake',
      //                             onPressed: () {
      //                               Navigator.pop(context);
      //                               Navigator.pop(context);
      //                               Navigator.pop(context);
      //                             })),
      //                     SizedBox(width: 15),
      //                     Expanded(
      //                         child: ElevatedButtonWithoutIcon(
      //                             text: 'Continue',
      //                             onPressed: () async {
      //                               BotToast.showLoading();
      //
      //                               /// compress video
      //                               await VideoCompress.setLogLevel(0);
      //                               final info =
      //                                   await VideoCompress.compressVideo(
      //                                       widget.file.path,
      //                                       quality: VideoQuality.MediumQuality,
      //                                       deleteOrigin: false,
      //                                       includeAudio: true);
      //                               BotToast.closeAllLoading();
      //                               Navigator.pop(context);
      //                               Navigator.pop(context);
      //                               Navigator.pop(context);
      //                               Navigator.pop(context, info.path);
      //                             }))
      //                   ],
      //                 ),
      //               ),
      //             )),
      //         Align(
      //           alignment: Alignment.center,
      //           child: InkWell(
      //               onTap: () {
      //                 setState(() {
      //                   _controller!.value.isPlaying
      //                       ? _controller!.pause()
      //                       : _controller!.play();
      //                 });
      //               },
      //               child: CircleAvatar(
      //                 radius: 33,
      //                 backgroundColor: Colors.black38,
      //                 child: Icon(
      //                     _controller!.value.isPlaying
      //                         ? Icons.pause
      //                         : Icons.play_arrow,
      //                     size: 50),
      //               )),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
