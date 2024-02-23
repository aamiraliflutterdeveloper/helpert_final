// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_one_video_module/question_one_video_rec_widget.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../../../../../../../main.dart';
// import '../../../../../../reusable_video_list/app_data.dart';
// import '../../../../../../reusable_video_list/reusable_video_list_page.dart';
//
// class QuestionOneVideoRecordScreen extends StatefulWidget {
//   const QuestionOneVideoRecordScreen({Key? key}) : super(key: key);
//
//   @override
//   _QuestionOneVideoRecordScreenState createState() =>
//       _QuestionOneVideoRecordScreenState();
// }
//
// class _QuestionOneVideoRecordScreenState
//     extends State<QuestionOneVideoRecordScreen> {
//   XFile? videoFile;
//   bool isRecording = false;
//
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
//       onWillPop: () {
//         if (Appdata.isFromSlider) {
//         } else {
//           Navigator.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pop(context);
//           NavRouter.pushReplacement(context, ReusableVideoListPage());
//         }
//         return Future.value(true);
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: QuestionOneVideoRecWidget(
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
