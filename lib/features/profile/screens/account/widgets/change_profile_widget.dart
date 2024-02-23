import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/api_endpoints.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/asset_paths.dart';
import '../../../../auth/repo/auth_repo.dart';

class ChangePictureWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final File? pickedImage;

  ChangePictureWidget({
    this.onPressed,
    this.pickedImage,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePictureWidget> createState() => _ChangePictureWidgetState();
}

class _ChangePictureWidgetState extends State<ChangePictureWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xFFEEF4FF)),
                child: widget.pickedImage == null
                    ? AuthRepo.instance.user.image.isNotEmpty
                        ? Container(
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        '$VIDEO_BASE_URL${AuthRepo.instance.user.image}'))),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(12.0, 5, 12, 0),
                            child: Image.asset(
                              ic_user_profile,
                              height: 100,
                              width: 102,
                              fit: BoxFit.fill,
                            ),
                          )
                    : Container(
                        width: 100,
                        height: 102,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(widget.pickedImage!))),
                      )),
            Positioned(
              bottom: -5,
              right: 0,
              left: 0,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.pureWhite,
                child: Icon(Icons.camera_alt),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class CroppedPictureWidget extends StatefulWidget {
//   final VoidCallback? onPressed;
//   final File? pickedImage;
//   const CroppedPictureWidget({
//     this.onPressed,
//     this.pickedImage,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<CroppedPictureWidget> createState() => _CroppedPictureWidgetState();
// }
//
// class _CroppedPictureWidgetState extends State<CroppedPictureWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onPressed,
//       child: Container(
//         height: 120,
//         child: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Color(0xFFEEF4FF)),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(12.0, 5, 12, 0),
//                 child: widget.pickedImage == null
//                     ? Image.asset(
//                         ic_user_profile,
//                         height: 93,
//                         width: 69,
//                         fit: BoxFit.fill,
//                       )
//                     : Image.file(
//                         widget.pickedImage!,
//                         height: 93,
//                         width: 69,
//                         fit: BoxFit.fill,
//                       ),
//               ),
//             ),
//             Positioned(
//                 bottom: 0,
//                 left: 25,
//                 child: CircleAvatar(
//                   radius: 22,
//                   backgroundColor: AppColors.pureWhite,
//                   child: Icon(Icons.camera_alt),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
