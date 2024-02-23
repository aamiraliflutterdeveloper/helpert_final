// import '../../../../../../reusable_video_list/app_dataeusable_video_list_page.dart';
//
// class UnrelatedQuestionRecScreen extends StatefulWidget {
//   const UnrelatedQuestionRecScreen({Key? key}) : super(key: key);
//
//   @override
//   _UnrelatedQuestionRecScreenState createState() =>
//       _UnrelatedQuestionRecScreenState();
// }
//
// class _UnrelatedQuestionRecScreenState
//     extends State<UnrelatedQuestionRecScreen> {
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
//                 child: UnrelatedVideoRecWidget(
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
