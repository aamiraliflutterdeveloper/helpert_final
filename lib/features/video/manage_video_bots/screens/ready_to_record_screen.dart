// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../common_widgets/cancel_publisher_topbar.dart';
// import '../../../../utils/nav_router.dart';
// import '../widgets/ready_to_record_video_content.dart';
//
// class ReadyToRecordScreen extends StatefulWidget {
//   final CameraController cameraController;
//   final bool isRearCameraSelected;
//   const ReadyToRecordScreen(
//       {Key? key,
//       required this.cameraController,
//       required this.isRearCameraSelected})
//       : super(key: key);
//
//   @override
//   _ReadyToRecordScreenState createState() => _ReadyToRecordScreenState();
// }
//
// class _ReadyToRecordScreenState extends State<ReadyToRecordScreen> {
//   XFile? videoFile;
//   bool isRecording = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           CancelPublishTopBar(
//             onTap: () {
//               NavRouter.pop(context);
//               // showDialog(
//               //     barrierDismissible: false,
//               //     context: context,
//               //     builder: (BuildContext context) {
//               //       return CustomAlertDialog(
//               //         noPressed: () {
//               //           NavRouter.pop(context);
//               //         },
//               //         yesPressed: () {
//               //           clearVideoModuleLists();
//               //           Navigator.of(context)
//               //               .popUntil((route) => route.isFirst);
//               //         },
//               //         title: 'Are you sure you want to discard all changes',
//               //       );
//               //     });
//             },
//           ),
//           Expanded(
//             child: ReadyToRecordVideoContent(
//                 cameraController: widget.cameraController,
//                 isRearCameraSelected: widget.isRearCameraSelected),
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
