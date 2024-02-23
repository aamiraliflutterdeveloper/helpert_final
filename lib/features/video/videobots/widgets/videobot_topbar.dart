import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/app_colors.dart';

import '../../../../common_widgets/components/text_view.dart';
import '../../../../constants/text_styles.dart';
import '../../../auth/repo/auth_repo.dart';
import '../../../other_user_profile/bloc/other_profile_bloc.dart';
import '../../../reusable_video_list/app_data.dart';
import '../../model/videos_model.dart';
import 'transparent_rounded_widget.dart';

class VideoBotTopBar extends StatefulWidget {
  const VideoBotTopBar(
      {Key? key,
      required this.videoViews,
      this.currentIndex,
      required this.isFollowing})
      : super(key: key);

  final int videoViews;
  final VideoBotModel? currentIndex;
  final int isFollowing;

  @override
  State<VideoBotTopBar> createState() => _VideoBotTopBarState();
}

class _VideoBotTopBarState extends State<VideoBotTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 5.0, // has the effect of softening the shadow
              spreadRadius: 5.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black.withOpacity(.8),
                AppColors.black.withOpacity(0),
              ])),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18) +
            EdgeInsets.only(top: 30),
        child: Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              splashRadius: 24,
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
                  Icon(Icons.keyboard_backspace, color: Colors.white, size: 25),
            ),
            Spacer(),
            // if (Appdata.isFollowing.isEmpty)
            //   TransparentRoundedWidget(
            //     verticalPadding: 6,
            //     horizontalPadding: 20,
            //     onTap: () {},
            //     child: TextView(
            //       'Follow',
            //       textStyle: TextStyles.mediumTextStyle(
            //           fontSize: 14, textColor: AppColors.pureWhite),
            //     ),
            //   ),
            // if (Appdata.isFollowing.isNotEmpty)
            TransparentRoundedWidget(
              verticalPadding: 6,
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.remove_red_eye, size: 16, color: Colors.white),
                  SizedBox(width: 8),
                  TextView(widget.videoViews.toString(),
                      textStyle: TextStyles.mediumTextStyle(
                          fontSize: 14, textColor: AppColors.pureWhite)),
                ],
              ),
            ),
            SizedBox(width: 10),
            AuthRepo.instance.user.userName != widget.currentIndex!.user_name
                ? Container(
                    child: Appdata.isFollowing.isEmpty
                        ? TransparentRoundedWidget(
                            verticalPadding: 6,
                            horizontalPadding: 20,
                            onTap: () {
                              if (AuthRepo.instance.user.userName !=
                                  widget.currentIndex!.user_name) {
                                if (widget.currentIndex!.isFollow == 1) {
                                  widget.currentIndex!.isFollow = 0;
                                  setState(() {});
                                } else {
                                  widget.currentIndex!.isFollow = 1;
                                  setState(() {});
                                }
                                context.read<OtherProfileBloc>().followUnFollow(
                                    widget.currentIndex!.user_id);
                              }
                            },
                            child: TextView(
                              widget.currentIndex!.isFollow == 1
                                  ? 'UnFollow'
                                  : 'Follow',
                              textStyle: TextStyles.mediumTextStyle(
                                  fontSize: 14, textColor: AppColors.pureWhite),
                            ),
                          )
                        : TransparentRoundedWidget(
                            verticalPadding: 6,
                            horizontalPadding: 20,
                            onTap: () {
                              if (AuthRepo.instance.user.userName !=
                                  widget.currentIndex!.user_name) {
                                if (Appdata.isFollowing[0] == 0) {
                                  Appdata.isFollowing.clear();
                                  Appdata.isFollowing.add(1);
                                  setState(() {});
                                } else {
                                  Appdata.isFollowing.clear();
                                  Appdata.isFollowing.add(0);
                                  setState(() {});
                                }
                                context.read<OtherProfileBloc>().followUnFollow(
                                    widget.currentIndex!.user_id);
                              }
                            },
                            child: TextView(
                              Appdata.isFollowing[0] == 1
                                  ? 'UnFollow'
                                  : widget.isFollowing == 1
                                      ? 'UnFollow'
                                      : 'Follow',
                              textStyle: TextStyles.mediumTextStyle(
                                  fontSize: 14, textColor: AppColors.pureWhite),
                            ),
                          ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
