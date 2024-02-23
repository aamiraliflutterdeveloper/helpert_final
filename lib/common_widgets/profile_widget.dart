import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helpert_app/constants/api_endpoints.dart';

import '../constants/app_colors.dart';
import '../constants/asset_paths.dart';
import '../constants/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  final String userName;
  final String specialization;
  final String? userImage;
  final String location;
  const ProfileWidget({
    Key? key,
    required this.userName,
    required this.specialization,
    this.userImage,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        userImage != null && userImage!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                    imageUrl: VIDEO_BASE_URL + userImage!,
                    height: 110,
                    width: 110,
                    fit: BoxFit.cover))
            : Container(
                alignment: Alignment.bottomCenter,
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF4FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Image.asset(ic_user_profile),
                ),
              ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                userName,
                style: TextStyles.boldTextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            if (specialization.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  specialization,
                  style: TextStyles.semiBoldTextStyle(
                      textColor: AppColors.acmeBlue),
                ),
              ),
            if (specialization.isNotEmpty)
              SizedBox(
                height: 8,
              ),
            Center(
              child: RatingBar.builder(
                ignoreGestures: true,
                itemSize: 20,
                initialRating: 4,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ),
            SizedBox(
              height: 8,
            ),
            if (location.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    location,
                    style:
                        TextStyles.regularTextStyle(textColor: AppColors.moon),
                  )
                ],
              )
          ],
        ),
      ],
    );
  }
}
