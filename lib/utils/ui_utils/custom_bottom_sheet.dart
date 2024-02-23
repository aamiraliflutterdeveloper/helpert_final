import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

import '../../common_widgets/components/text_view.dart';
import '../nav_router.dart';

class CustomBottomSheet {
  // image selection
  static Future<String> imageSelectionBottomSheet(BuildContext context,
      {bool hasDeleteIcon = false}) async {
    return await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )),
          builder: (context) {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          TextView(
                            'Send Picture',
                            textStyle: TextStyles.regularTextStyle(fontSize: 16)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          if (hasDeleteIcon)
                            IconButton(
                              splashRadius: 26,
                              icon: Icon(Icons.delete_outline_outlined,
                                  color: Colors.black54),
                              onPressed: () {
                                NavRouter.pop(context, 'delete');
                              },
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            NavRouter.pop(context, 'camera');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 16),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 28,
                                  color: AppColors.acmeBlue,
                                ),
                                SizedBox(height: 3),
                                TextView(
                                  'Camera',
                                  textStyle:
                                      TextStyles.regularTextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            NavRouter.pop(context, 'gallery');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 16),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 28,
                                  color: AppColors.acmeBlue,
                                ),
                                SizedBox(height: 3),
                                TextView(
                                  'Gallery',
                                  textStyle:
                                      TextStyles.regularTextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ) ??
        Future.value('nothing');
  }
}
