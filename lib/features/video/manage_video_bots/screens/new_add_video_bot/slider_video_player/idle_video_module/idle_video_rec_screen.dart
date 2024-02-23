 // IdleVideoRecordingScreen({Key? key}) : super(key: key);
//
//   @override
//   _IdleVideoRecordingScreenState createState() =>
//       _IdleVideoRecordingScreenState();
// }
//
// class _IdleVideoRecordingScreenState extends State<IdleVideoRecordingScreen> {
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
//                 child: IdleVideoRecWidget(
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
