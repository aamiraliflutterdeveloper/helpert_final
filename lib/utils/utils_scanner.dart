//
// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
//
// class UtilsScanner {
//   UtilsScanner._();
//
//   static Future<CameraDescription> getCamera(
//       CameraLensDirection cameraLensDirection) async {
//     return await availableCameras().then((List<CameraDescription> cameras) =>
//         cameras.firstWhere((CameraDescription cameraDescription) =>
//             cameraDescription.lensDirection == cameraLensDirection));
//   }
//
//   static InputImageRotation rotationIntToImageRotation(int rotation) {
//     switch (rotation) {
//       case 0:
//         return InputImageRotation.rotation0deg;
//       case 90:
//         return InputImageRotation.rotation90deg;
//       case 180:
//         return InputImageRotation.rotation180deg;
//       default:
//         assert(rotation == 270);
//         return InputImageRotation.rotation270deg;
//     }
//   }
//
//   static Uint8List concatenatePlanes(List<Plane> planes) {
//     final WriteBuffer allBytes = WriteBuffer();
//
//     for (Plane plane in planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//
//     return allBytes.done().buffer.asUint8List();
//   }
//
//   static InputImageData buildMetaData(
//       CameraImage image, InputImageRotation rotation) {
//     return InputImageData(
//         size: Size(image.width.toDouble(), image.height.toDouble()),
//         inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw)!,
//         planeData: image.planes.map((Plane plane) {
//           return InputImagePlaneMetadata(
//               bytesPerRow: plane.bytesPerRow,
//               height: plane.height,
//               width: plane.width);
//         }).toList(),
//         imageRotation: rotation);
//   }
//
//   static Future<dynamic> detect({
//     required CameraImage image,
//     required Future<dynamic> Function(InputImage image) detectInImage,
//     required int imageRotation,
//   }) async {
//     return detectInImage(InputImage.fromBytes(
//         bytes: concatenatePlanes(image.planes),
//         inputImageData:
//             buildMetaData(image, rotationIntToImageRotation(imageRotation))));
//   }
// }
