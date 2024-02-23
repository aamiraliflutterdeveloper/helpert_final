// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
// import 'package:helpert_app/main.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../../../../../../reusable_video_list/reusable_video_list_page.dart';
// import 'intro_video_rec_widget.dart';
//
// class IntroVideoRecScreen extends StatefulWidget {
//   const IntroVideoRecScreen({Key? key}) : super(key: key);
//
//   @override
//   _IntroVideoRecScreenState createState() => _IntroVideoRecScreenState();
// }
//
// class _IntroVideoRecScreenState extends State<IntroVideoRecScreen> {
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
//       onWillPop: () {
//         if (Appdata.isFromSlider) {
//         } else {
//           Navigator.pop(context);
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
//                 child: IntroVideoRecWidget(
//                   cameraController: cameraController!,
//                   callBack: () {
//                     isRearCameraSelected = !isRearCameraSelected;
//                     setState(() {});
//                     initCamera(cameras[isRearCameraSelected ? 0 : 1]);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
