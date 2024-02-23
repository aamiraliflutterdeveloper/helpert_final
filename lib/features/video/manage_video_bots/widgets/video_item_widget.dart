// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
//
// class IntroductionVideoWidget extends StatefulWidget {
//   // final VideoPlayerController controller;
//   final bool isLoading;
//   final bool finishedPlaying;
//   const IntroductionVideoWidget(
//       {Key? key,
//       // required this.controller,
//       required this.isLoading,
//       required this.finishedPlaying})
//       : super(key: key);
//
//   @override
//   State<IntroductionVideoWidget> createState() =>
//       _IntroductionVideoWidgetState();
// }
//
// class _IntroductionVideoWidgetState extends State<IntroductionVideoWidget> {
//   bool isClicked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         children: [
//           SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: widget.controller.value.isInitialized
//                   ? AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: VideoPlayer(widget.controller),
//                     )
//                   : Container()),
//           Positioned(
//             top: 10,
//             left: 10,
//             child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Icon(Icons.cancel, color: AppColors.pureWhite)),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: widget.isLoading
//                 ? const CircleAvatar(
//                     radius: 33,
//                     backgroundColor: Colors.transparent,
//                     child: Center(child: CircularProgressIndicator()))
//                 : Center(
//                     child: ButtonTheme(
//                     height: 70.0,
//                     minWidth: 70.0,
//                     child: AnimatedOpacity(
//                       opacity: isClicked ? 1.0 : 0.0,
//                       duration: Duration(milliseconds: 200),
//                       child: RaisedButton(
//                         padding: EdgeInsets.all(10.0),
//                         color: Colors.transparent,
//                         textColor: Colors.white,
//                         onPressed: () {
//                           setState(() {
//                             isClicked = true;
//                             if (widget.controller.value.isPlaying) {
//                               widget.controller.pause();
//                             } else {
//                               widget.controller.play();
//                             }
//                           });
//                         },
//                         child: Icon(
//                           widget.controller.value.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow,
//                           size: 50.0,
//                         ),
//                       ),
//                     ),
//                   )),
//           ),
//         ],
//       ),
//     );
//   }
// }
