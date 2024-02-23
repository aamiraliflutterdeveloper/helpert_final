import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/custom_dialog.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/video/bloc/video/delete_video_bloc.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/asset_paths.dart';
import '../../video/bloc/video/delete_video_state.dart';

class HomeGridViewItemWidget extends StatelessWidget {
  final String route;
  final String image;
  final String name;
  final String speciality;
  final String question;
  final Function() deleteFunction;
  final GestureTapCallback? onTap;
  final String? videoImage;

  const HomeGridViewItemWidget(
      {Key? key,
      required this.image,
      required this.name,
      required this.speciality,
      required this.question,
      this.onTap,
      this.videoImage,
      required this.route,
      required this.deleteFunction()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Stack(
        children: [
          videoImage != null
              ? Container(
                  height: 240,
                  // padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.moon,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(100), // Image radius
                        child: CachedNetworkImage(
                            imageUrl: videoImage!, fit: BoxFit.cover)),
                  ))
              : Container(
                  height: 240,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.moon),
                ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    image.isEmpty
                        ? CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.acmeBlue,
                            child: Image.asset(ic_user_profile,
                                height: 25, fit: BoxFit.cover),
                          )
                        : CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.acmeBlue,
                            backgroundImage:
                                CachedNetworkImageProvider('$APP_URL$image')),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            textAlign: TextAlign.left,
                            style: TextStyles.regularTextStyle(
                                fontSize: 10, textColor: AppColors.black),
                          ),
                          Text(
                            speciality,
                            textAlign: TextAlign.left,
                            style: TextStyles.regularTextStyle(
                                fontSize: 8, textColor: AppColors.acmeBlue),
                          ),
                        ],
                      ),
                    ),
                    if (route == 'profile')
                      BlocListener<DeleteVideoBloc, DeleteVideoState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        child: GestureDetector(
                            onTap: () {
                              CustomDialogs.showDeleteDialog(context,
                                  deleteFunction: deleteFunction,
                                  cancelFunction: () {
                                Navigator.pop(context);
                              });
                            },
                            child: Icon(Icons.more_horiz,
                                color: AppColors.pureWhite)),
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question,
                    style: TextStyles.mediumTextStyle(
                        fontSize: 10, textColor: AppColors.pureWhite),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
