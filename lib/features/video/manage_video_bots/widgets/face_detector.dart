// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
//
// class FaceDetectorPainter extends CustomPainter {
//   final Size absoluteImageSize;
//   final List<Face> faces;
//   final Function(Rect) onChange;
//   CameraLensDirection cameraLensDirection;
//
//   FaceDetectorPainter(this.absoluteImageSize, this.faces,
//       this.cameraLensDirection, this.onChange);
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double scaleX = size.width / absoluteImageSize.width;
//     final double scaleY = size.height / absoluteImageSize.height;
//
//     Paint paint;
//     for (Face face in faces) {
//       if (face.headEulerAngleY! > 10 || face.headEulerAngleY! < -10) {
//         paint = Paint()
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 3.0
//           ..color = Colors.red;
//       } else {
//         paint = Paint()
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 3.0
//           ..color = Colors.green;
//       }
//       Rect rect = Rect.fromLTRB(
//         cameraLensDirection == CameraLensDirection.front
//             ? (absoluteImageSize.width - face.boundingBox.right) * scaleX
//             : face.boundingBox.left * scaleX,
//         face.boundingBox.top * scaleY,
//         cameraLensDirection == CameraLensDirection.front
//             ? (absoluteImageSize.width - face.boundingBox.left) * scaleX
//             : face.boundingBox.right * scaleX,
//         face.boundingBox.bottom * scaleY,
//       );
//       onChange(rect);
//       // canvas.drawRect(
//       //     Rect.fromLTRB(
//       //       cameraLensDirection == CameraLensDirection.front
//       //           ? (absoluteImageSize.width - face.boundingBox.right) * scaleX
//       //           : face.boundingBox.left * scaleX,
//       //       face.boundingBox.top * scaleY,
//       //       cameraLensDirection == CameraLensDirection.front
//       //           ? (absoluteImageSize.width - face.boundingBox.left) * scaleX
//       //           : face.boundingBox.right * scaleX,
//       //       face.boundingBox.bottom * scaleY,
//       //     ),
//       //     paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(FaceDetectorPainter oldDelegate) {
//     return oldDelegate.absoluteImageSize != absoluteImageSize ||
//         oldDelegate.faces != faces;
//   }
// }
