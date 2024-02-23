// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../widgets/tap_record_video_content.dart';
//
// class TapToStartRecordScreen extends StatefulWidget {
//   final CameraController cameraController;
//   final bool isRearCameraSelected;
//   const TapToStartRecordScreen(
//       {Key? key,
//       required this.cameraController,
//       required this.isRearCameraSelected})
//       : super(key: key);
//
//   @override
//   _TapToStartRecordScreenState createState() => _TapToStartRecordScreenState();
// }
//
// class _TapToStartRecordScreenState extends State<TapToStartRecordScreen> {
//   XFile? videoFile;
//   bool isRecording = false;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (isRecording == false) {
//           NavRouter.pop(context);
//         }
//         return false;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: TapRecordVideoContent(
//                     cameraController: widget.cameraController,
//                     isRearCameraSelected: widget.isRearCameraSelected),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
