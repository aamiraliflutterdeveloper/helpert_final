// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../../../../../../../main.dart';
// import '../../../../../../reusable_video_list/app_data.dart';
// import '../../../../../../reusable_video_list/reusable_video_list_page.dart';
// import 'question_two_video_rec_widget.dart';
//
// class QuestionTwoVideoRecordScreen extends StatefulWidget {
//   const QuestionTwoVideoRecordScreen({Key? key}) : super(key: key);
//
//   @override
//   _QuestionTwoVideoRecordScreenState createState() =>
//       _QuestionTwoVideoRecordScreenState();
// }
//
// class _QuestionTwoVideoRecordScreenState
//     extends State<QuestionTwoVideoRecordScreen> {
//   XFile? videoFile;
//   bool isRecording = false;
//   bool isRearCameraSelected = false;
//   CameraController? cameraController;
//
//   Future initCamera(CameraDescription cameraDescription) async {
//     cameraController =
//         CameraController(cameraDescription, ResolutionPreset.high);
//     try {
//       await cameraController!.initialize().then((_) {
//         if (!mounted) return;
//         setState(() {});
//       });
//     } on CameraException catch (e) {}
//   }
//
//   @override
//   initState() {
//     super.initState();
//     initCamera(cameras[1]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (Appdata.isFromSlider) {
//         } else {
//           Navigator.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//
//           NavRouter.pushReplacement(context, ReusableVideoListPage());
//         }
//         return Future.value(true);
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: QuestionTwoVideoRecWidget(
//                     cameraController: cameraController!,
//                     callBack: () {
//                       isRearCameraSelected = !isRearCameraSelected;
//                       setState(() {});
//                       initCamera(cameras[isRearCameraSelected ? 0 : 1]);
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
