// import '../../../../../../../utils/nav_routerort 'idle_video_rec_screen.dart';
//
// class IdleVideoCameraContent extends StatefulWidget {
//   const IdleVideoCameraContent({
//     Key? key,
//     required this.cameraController,
//     required this.isRearCameraSelected,
//     this.childRect,
//     this.imageSensitivity,
//     required this.callback,
//   }) : super(key: key);
//
//   final CameraController cameraController;
//   final bool isRearCameraSelected;
//   final Rect? childRect;
//   final double? imageSensitivity;
//   final VoidCallback callback;
//
//   @override
//   State<IdleVideoCameraContent> createState() => _IdleVideoCameraContentState();
// }
//
// class _IdleVideoCameraContentState extends State<IdleVideoCameraContent> {
//   final containerKey = GlobalKey();
//   Rect? parentRect;
//
//   var gotPosition = false;
//   bool startAnimation = false;
//   var redPositionX;
//   var redPositionY;
//   var redWidth;
//   var redHeight;
//
//   _afterLayout(_) {
//     printWidgetPosition();
//     _getPositions();
//     _getSizes();
//     setState(() {
//       gotPosition = true;
//     });
//   }
//
//   _getSizes() {
//     final RenderBox renderBoxRed =
//         containerKey.currentContext!.findRenderObject() as RenderBox;
//     final sizeRed = renderBoxRed.size;
//     redWidth = sizeRed.width;
//     redHeight = sizeRed.height;
//   }
//
//   _getPositions() {
//     final RenderBox renderBoxRed =
//         containerKey.currentContext!.findRenderObject() as RenderBox;
//     final positionRed = renderBoxRed.localToGlobal(Offset.zero);
//     redPositionY = positionRed.dy;
//     redPositionX = positionRed.dx;
//   }
//
//   printWidgetPosition() {
//     parentRect = containerKey.globalPaintBounds;
//
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     printWidgetPosition();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Container(
//         width: screenWidth,
//         height: screenHeight,
//         decoration: const BoxDecoration(
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
//             (widget.cameraController.value.isInitialized)
//                 ? Container(
//                     height: MediaQuery.of(context).size.height,
//                     child: CameraPreview(widget.cameraController))
//                 : Container(
//                     color: Colors.black,
//                     child: const Center(child: CircularProgressIndicator())),
//             Positioned(
//                 top: MediaQuery.of(context).size.height * .1,
//                 child: Container(
//                   key: containerKey,
//                   child: Image.asset(ic_face_setting_image,
//                       color: (widget.childRect != null &&
//                               parentRect != null &&
//                               widget.childRect!.left >
//                                   parentRect!.left - screenHeight * .05 &&
//                               widget.childRect!.top >
//                                   parentRect!.top - screenHeight * .12 &&
//                               widget.childRect!.right <
//                                   parentRect!.right + screenHeight * .035 &&
//                               widget.childRect!.bottom <
//                                   parentRect!.bottom + screenHeight * .03)
//                           ? Colors.green
//                           : Colors.red),
//                 )),
//             AnimatedPositioned(
//               duration: const Duration(milliseconds: 600),
//               top: widget.childRect != null && parentRect != null
//                   ? (widget.childRect!.left >
//                               parentRect!.left - screenHeight * .05 &&
//                           widget.childRect!.top >
//                               parentRect!.top - screenHeight * .12 &&
//                           widget.childRect!.right <
//                               parentRect!.right + screenHeight * .035 &&
//                           widget.childRect!.bottom <
//                               parentRect!.bottom + screenHeight * .03)
//                       ? screenHeight * .04
//                       : screenHeight * .58
//                   : screenHeight * .58,
//               curve: Curves.easeInCubic,
//               child: !(widget.childRect != null &&
//                       parentRect != null &&
//                       widget.childRect!.left >
//                           parentRect!.left - screenHeight * .05 &&
//                       widget.childRect!.top >
//                           parentRect!.top - screenHeight * .12 &&
//                       widget.childRect!.right <
//                           parentRect!.right + screenHeight * .035 &&
//                       widget.childRect!.bottom <
//                           parentRect!.bottom + screenHeight * .03)
//                   ? Column(
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.photo_camera,
//                                 color: Color(0xFF49eae4)),
//                             const SizedBox(width: 10),
//                             Text("Camera distance",
//                                 style: TextStyles.boldTextStyle(
//                                     textColor: Color(0xFF49eae4))),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text("Keep your face inside the box",
//                             style: TextStyles.mediumTextStyle(
//                                 textColor: AppColors.pureWhite)),
//                       ],
//                     )
//                   : Row(
//                       children: [
//                         const CircleAvatar(
//                           radius: 10,
//                           backgroundColor: AppColors.pureWhite,
//                           child: Icon(
//                             Icons.check,
//                             size: 15,
//                             color: AppColors.silver,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Text("Camera Positioning",
//                             style: TextStyles.mediumTextStyle(
//                                 textColor: AppColors.snow, fontSize: 14)),
//                       ],
//                     ),
//             ),
//             AnimatedPositioned(
//                 duration: const Duration(milliseconds: 600),
//                 top: (widget.imageSensitivity != null &&
//                         widget.imageSensitivity! < 1200)
//                     ? screenHeight * .07
//                     : screenHeight * .67,
//                 curve: Curves.easeInCubic,
//                 child: Row(
//                   children: [
//                     const Icon(Icons.volume_down, color: AppColors.pureWhite),
//                     const SizedBox(width: 6),
//                     Text(
//                       "Ambient",
//                       style: TextStyles.regularTextStyle(
//                           textColor: AppColors.pureWhite),
//                     ),
//                   ],
//                 )),
//             // if ((widget.childRect != null &&
//             //         parentRect != null &&
//             //         widget.childRect!.left >
//             //             parentRect!.left - screenHeight * .05 &&
//             //         widget.childRect!.top >
//             //             parentRect!.top - screenHeight * .12 &&
//             //         widget.childRect!.right <
//             //             parentRect!.right + screenHeight * .035 &&
//             //         widget.childRect!.bottom <
//             //             parentRect!.bottom + screenHeight * .03) &&
//             //     (widget.imageSensitivity != null &&
//             //         widget.imageSensitivity! < 1200))
//             Positioned(
//                 bottom: 15,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 15),
//                     Container(
//                       width: 210,
//                       height: 50,
//                       child: ElevatedButtonWithIcon(
//                         borderRadius: 0,
//                         borderColor: AppColors.failure,
//                         onTap: () {
//                           widget.cameraController.stopImageStream();
//                           NavRouter.push(context, IdleVideoRecordingScreen())
//                               .then((value) {
//                             widget.callback();
//                           });
//                         },
//                         text: 'Record Idle Video',
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
//
// extension GlobalKeyExtension on GlobalKey {
//   Rect? get globalPaintBounds {
//     final renderObject = currentContext?.findRenderObject();
//     final translation = renderObject?.getTransformTo(null).getTranslation();
//     if (translation != null && renderObject?.paintBounds != null) {
//       final offset = Offset(translation.x, translation.y);
//       return renderObject!.paintBounds.shift(offset);
//     } else {
//       return null;
//     }
//   }
// }
