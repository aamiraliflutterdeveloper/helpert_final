import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helpert_app/features/auth/models/user_model.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';
import '../../../constants/api_endpoints.dart';

class OtherProfileWidget extends StatelessWidget {
  final UserModel user;
  const OtherProfileWidget({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDoctor = user.userRole == 3;
    return Row(
      children: [
        user.image.isEmpty
            ? Container(
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
              )
            : Container(
                width: 90,
                height: 105,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            '$VIDEO_BASE_URL${user.image}'))),
              ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          height: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: isDoctor
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyles.boldTextStyle(fontSize: 18),
              ),
              if (isDoctor)
                Text(
                  user.specialization,
                  style: TextStyles.semiBoldTextStyle(
                      textColor: AppColors.acmeBlue),
                ),
              if (isDoctor)
                Center(
                  child: RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 20,
                    initialRating: user.rating,
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
              if (isDoctor)
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
                      user.location,
                      style: TextStyles.regularTextStyle(
                          textColor: AppColors.moon),
                    )
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
