import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/features/other_user_profile/screens/other_profile_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../common_widgets/components/text_view.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/consts.dart';
import '../../../constants/text_styles.dart';

class BookingUserDetailWidget extends StatelessWidget {
  final double topGap;
  final int doctorId;
  final String name;
  final String image;
  final String specialization;
  final int sessionRate;
  final String timeZone;

  const BookingUserDetailWidget(
      {Key? key, required this.name,
      required this.image,
      required this.specialization,
      required this.sessionRate,
      required this.timeZone,
      required this.doctorId,
      this.topGap = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: topGap,
        ),
        image.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  debugPrint('doctor id :: $doctorId');

                  NavRouter.push(
                      context, OtherUserProfileScreen(userId: doctorId));
                },
                child: Hero(
                  tag: doctorId,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        CachedNetworkImageProvider(APP_URL + image),
                    backgroundColor: AppColors.acmeBlue,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  debugPrint('doctor id :: $doctorId');
                  NavRouter.push(
                      context, OtherUserProfileScreen(userId: doctorId));
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/images/png/no_profile.png'),
                  backgroundColor: AppColors.acmeBlue,
                ),
              ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            NavRouter.push(context, OtherUserProfileScreen(userId: doctorId));
          },
          child: TextView(
            name,
            textStyle: TextStyles.semiBoldTextStyle(
                fontSize: 15,
                textColor: AppColors.black,
                fontFamily: proximaFamily),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        TextView(
          specialization,
          textStyle: TextStyles.regularTextStyle(
              fontSize: 13,
              textColor: Color(0xFF0261FE),
              fontFamily: proximaFamily),
        ),
        if (sessionRate != 0)
          SizedBox(
            height: 8,
          ),
        if (sessionRate != 0)
          TextView(
            'Session price \$$sessionRate‍',
            textStyle: TextStyles.regularTextStyle(
                fontSize: 15,
                textColor: Color(0xFF666666),
                fontFamily: proximaFamily),
          ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              timeZone,
              textStyle: TextStyles.regularTextStyle(
                  fontSize: 14,
                  textColor: Color(0xFF999999),
                  fontFamily: proximaFamily),
            ),
            // SizedBox(
            //   width: 4,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Icon(
            //     Icons.keyboard_arrow_down_outlined,
            //     color: AppColors.black,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
