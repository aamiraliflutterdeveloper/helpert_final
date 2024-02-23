import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';
import 'package:helpert_app/features/video/videobots/widgets/transparent_rounded_widget.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../common_widgets/components/text_view.dart';
import '../../../../common_widgets/custom_dialog.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';
import '../../../auth/repo/auth_repo.dart';
import '../../../book_call/screens/booking_slot_screen.dart';
import '../../bloc/video/fetch_all_videos_bloc.dart';

class VideoBotProfileWidget extends StatefulWidget {
  final VideoBotModel videoData;
  final Function(String, int) onTap;
  final GestureTapCallback tapOnProfile;

  const VideoBotProfileWidget({
    required this.onTap,
    required this.tapOnProfile,
    required this.videoData,
    Key? key,
  }) : super(key: key);

  @override
  State<VideoBotProfileWidget> createState() => _VideoBotProfileWidgetState();
}

class _VideoBotProfileWidgetState extends State<VideoBotProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 16),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            AppColors.black.withOpacity(.45),
            AppColors.black.withOpacity(.8),
          ])),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.tapOnProfile,
            child: Row(
              children: [
                widget.videoData.user_image.isEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: Image.asset(ic_user_profile,
                            height: 30, fit: BoxFit.cover),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        backgroundImage: CachedNetworkImageProvider(
                            '$APP_URL${widget.videoData.user_image}'),
                      ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      '${widget.videoData.firstName} ${widget.videoData.lastName}',
                      textStyle: TextStyles.semiBoldTextStyle(
                          textColor: AppColors.pureWhite, fontSize: 16),
                    ),
                    TextView(
                      widget.videoData.specialization,
                      textStyle: TextStyles.regularTextStyle(
                          fontSize: 14, textColor: AppColors.pureWhite),
                    ),
                  ],
                ),
                Spacer(),
                if (AuthRepo.instance.user.userId != widget.videoData.user_id)
                  TransparentRoundedWidget(
                    verticalPadding: 7,
                    horizontalPadding: 8,
                    onTap: () {
                      if (widget.videoData.paymentStatus == 'complete') {
                        NavRouter.push(
                          context,
                          BookingSlotScreen(
                            doctorId: widget.videoData.user_id,
                            doctorImage: widget.videoData.user_image,
                            doctorName:
                                '${widget.videoData.firstName} ${widget.videoData.lastName}',
                            specialization: widget.videoData.specialization,
                            sessionRate: widget.videoData.sessionRate,
                            timeZone: widget.videoData.timezone,
                          ),
                        );
                      } else {
                        CustomDialogs.showPaymentStatusNotificationDialog(
                            context, onOkTap: () {
                          context.read<FetchAllVideosBloc>().sendNotification(
                              doctorId: widget.videoData.user_id);
                          NavRouter.pop(context);
                        });
                      }
                    },
                    child: Row(
                      children: [
                        SvgImage(
                            path: ic_cam_popup,
                            width: 20,
                            height: 20,
                            color: Colors.white),
                        SizedBox(width: 6),
                        TextView(
                          'Book a call',
                          textStyle: TextStyles.mediumTextStyle(
                              fontSize: 14, textColor: AppColors.pureWhite),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("@${widget.videoData.user_name}",
                  style: TextStyles.boldTextStyle(
                      fontSize: 15, textColor: AppColors.pureWhite))),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(widget.videoData.main_title,
                style: TextStyles.regularTextStyle(
                    textColor: AppColors.pureWhite, fontSize: 13),
                textAlign: TextAlign.left),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
