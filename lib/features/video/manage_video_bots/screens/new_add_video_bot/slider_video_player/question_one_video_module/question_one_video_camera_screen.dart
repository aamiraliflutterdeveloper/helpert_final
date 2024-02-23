// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:helpert_app/features/video/manage_video_bots/screens/new_add_video_bot/slider_video_player/question_one_video_module/question_one_camera_content.dart';
// import 'package:helpert_app/main.dart';
// import 'package:helpert_app/utils/nav_router.dart';
// import 'package:helpert_app/utils/utils_scanner.dart';
//
// import '../../../../../../../common_widgets/cancel_publisher_topbar.dart';
//
// class QuestionOneCameraScreen extends StatefulWidget {
//   const QuestionOneCameraScreen({Key? key}) : super(key: key);
//
//   @override
//   _QuestionOneCameraScreenState createState() =>
//       _QuestionOneCameraScreenState();
// }
//
// class _QuestionOneCameraScreenState extends State<QuestionOneCameraScreen> {
//   final FaceDetector faceDetector = FaceDetector(
//       options: FaceDetectorOptions(
//     enableContours: true,
//     minFaceSize: 1.0,
//     performanceMode: FaceDetectorMode.fast,
//     enableClassification: true,
//   ));
//   CameraController? cameraController;
//   late Future<void> cameraValue;
//   final containerKey = GlobalKey();
//
//   dynamic scanResults;
//   bool isWorking = false;
//
//   Rect? childRect;
//   double? imageSensitivity;
//   List<Face>? faceList;
//   CameraDescription? description;
//   CameraLensDirection cameraLensDirection = CameraLensDirection.front;
//
//   var startAnimation = false;
//   @override
//   void initState() {
//     initCamera(cameras[_isRearCameraSelected ? 0 : 1]);
//     // cameraController = CameraController(cameras[0], ResolutionPreset.high);
//
//     // cameraValue = cameraController.initialize();
//
//     super.initState();
//   }
//
//   Future initCamera(CameraDescription cameraDescription) async {
//     description = await UtilsScanner.getCamera(cameraLensDirection);
//
//     cameraController =
//         CameraController(cameraDescription, ResolutionPreset.high);
//
//     try {
//       await cameraController!.initialize().then((_) {
//         if (!mounted) return;
//         cameraController!.startImageStream((imageFromStream) async {
//           if (!isWorking) {
//             isWorking = true;
//             await performDetectionOnStreamFrames(imageFromStream);
//           }
//         });
//         setState(() {});
//       });
//     } on CameraException catch (e) {}
//   }
//
//   performDetectionOnStreamFrames(CameraImage cameraImage) async {
//     UtilsScanner.detect(
//       image: cameraImage,
//       detectInImage: faceDetector.processImage,
//       imageRotation: description!.sensorOrientation,
//     ).then((results) {
//       imageSensitivity = cameraImage.sensorSensitivity;
//       if (cameraImage.sensorSensitivity! > 1200) {
//       } else {}
//       setState(() {
//         scanResults = results;
//       });
//     }).whenComplete(() {
//       isWorking = false;
//     });
//   }
//
//   bool _isRearCameraSelected = false;
//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     cameraController!.dispose();
//     super.dispose();
//   }
//
//   XFile? videoFile;
//   bool isRecording = false;
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> stackWidgetChildren = [];
//     Size size = MediaQuery.of(context).size;
//     buildResult(size);
//
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
//           if (cameraController != null)
//             Expanded(
//               child: QuestionOneCameraContent(
//                   imageSensitivity: imageSensitivity,
//                   childRect: childRect,
//                   cameraController: cameraController!,
//                   isRearCameraSelected: _isRearCameraSelected),
//             ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
//
//   buildResult(Size size) {
//     //   if (scanResults == null ||
//     //       cameraController == null ||
//     //       !cameraController.value.isInitialized) {
//     //     return const Text(
//     //       'Empty',
//     //       style: TextStyle(color: Colors.white, fontSize: 20),
//     //     );
//     //   }
//     //
//     //   final Size imageSize = Size(cameraController.value.previewSize!.height,
//     //       cameraController.value.previewSize!.width);
//     //
//     //   CustomPainter customPainter = FaceDetectorPainter(
//     //       imageSize, scanResults, cameraLensDirection, (Rect value) {
//     //     childRect = value;
//     //   });
//     //   return CustomPaint(
//     //     painter: customPainter,
//     //   );
//     // }
//
//     if (scanResults != null &&
//         cameraController != null &&
//         cameraController!.value.isInitialized) {
//       final Size imageSize = Size(cameraController!.value.previewSize!.height,
//           cameraController!.value.previewSize!.width);
//       final double scaleX = size.width / imageSize.width;
//       final double scaleY = size.height / imageSize.height;
//
//       for (Face face in scanResults) {
//         Rect rect = Rect.fromLTRB(
//           cameraLensDirection == CameraLensDirection.front
//               ? (imageSize.width - face.boundingBox.right) * scaleX
//               : face.boundingBox.left * scaleX,
//           face.boundingBox.top * scaleY,
//           cameraLensDirection == CameraLensDirection.front
//               ? (imageSize.width - face.boundingBox.left) * scaleX
//               : face.boundingBox.right * scaleX,
//           face.boundingBox.bottom * scaleY,
//         );
//         childRect = rect;
//         setState(() {});
//       }
//     }
//   }
// }
