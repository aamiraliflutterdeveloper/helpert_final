import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/consts.dart';
import 'package:helpert_app/constants/text_styles.dart';

class SpecialistWidget extends StatelessWidget {
  final String name;
  final String speciality;
  final double rating;
  final int reviews;
  final String image;
  const SpecialistWidget(
      {Key? key,
      required this.name,
      required this.speciality,
      required this.rating,
      required this.reviews,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          //shadowColor: Color(0xFFE5E5E5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE5E5E5).withOpacity(.4),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: AppColors.pureWhite),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image.isNotEmpty
              ? CircleAvatar(
                  radius: 38,
                  backgroundColor: AppColors.moon,
                  backgroundImage:
                      CachedNetworkImageProvider(VIDEO_BASE_URL + image),
                )
              : CircleAvatar(
                  radius: 38,
                  backgroundColor: AppColors.moon,
                  backgroundImage:
                      AssetImage('assets/images/png/no_profile.png'),
                ),
          const SizedBox(
            height: 18,
          ),
          Text(
            name,
            style: TextStyles.regularTextStyle(
                fontSize: 16,
                textColor: AppColors.black,
                fontFamily: museoFamily),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            speciality,
            style: TextStyles.mediumTextStyle(
                fontSize: 12,
                textColor: AppColors.greyText,
                fontFamily: museoFamily),
          ),
          const SizedBox(
            height: 4,
          ),
          // ⭐️ $rating*
          if (speciality.isNotEmpty)
            Text(
              '⭐ $rating',
              style: TextStyles.regularTextStyle(
                  fontSize: 10,
                  textColor: AppColors.greyText,
                  fontFamily: museoFamily),
            ),
        ],
      ),
    );
  }
}
