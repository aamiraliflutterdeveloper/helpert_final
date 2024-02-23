// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../common_widgets/bottons/elevated_button_with_icon.dart';
// import '../../../../constants/app_colors.dart';
// import '../../../../constants/asset_paths.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../utils/nav_router.dart';
// import '../screens/tap_to_record_screen.dart';
//
// class ReadyToRecordVideoContent extends StatelessWidget {
//   const ReadyToRecordVideoContent({
//     Key? key,
//     required this.cameraController,
//     required this.isRearCameraSelected,
//   }) : super(key: key);
//   final bool isRearCameraSelected;
//   final CameraController cameraController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 20,
//               spreadRadius: 4,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             (cameraController.value.isInitialized)
//                 ? Container(
//                     height: MediaQuery.of(context).size.height,
//                     child: CameraPreview(cameraController))
//                 : Container(
//                     color: Colors.black,
//                     child: const Center(child: CircularProgressIndicator())),
//             Positioned(
//                 top: 55,
//                 child: Container(
//                   child: Image.asset(ic_face_setting_image),
//                 )),
//             Positioned(
//                 top: 10,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 10,
//                           backgroundColor: AppColors.pureWhite,
//                           child: Icon(
//                             Icons.check,
//                             size: 15,
//                             color: AppColors.silver,
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Text("Camera Positioning",
//                             style: TextStyles.mediumTextStyle(
//                                 textColor: AppColors.snow, fontSize: 14)),
//                       ],
//                     ),
//                     SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.volume_down,
//                           color: AppColors.pureWhite,
//                           size: 25,
//                         ),
//                         SizedBox(width: 7),
//                         Text(
//                           "Ambient noise",
//                           style: TextStyles.regularTextStyle(
//                               textColor: AppColors.pureWhite, fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )),
//             Positioned(
//                 bottom: 50,
//                 child: Column(
//                   children: [
//                     SizedBox(height: 15),
//                     Container(
//                       width: 200,
//                       height: 50,
//                       child: ElevatedButtonWithIcon(
//                         borderRadius: 0,
//                         borderColor: AppColors.failure,
//                         onTap: () {
//                           NavRouter.push(
//                               context,
//                               TapToStartRecordScreen(
//                                 cameraController: cameraController,
//                                 isRearCameraSelected: isRearCameraSelected,
//                               ));
//                         },
//                         text: 'Ready to Record',
//                         primaryColor: AppColors.failure,
//                         onPrimaryColor: AppColors.pureWhite,
//                         prefixIcon: ic_camera,
//                       ),
//                     ),
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
