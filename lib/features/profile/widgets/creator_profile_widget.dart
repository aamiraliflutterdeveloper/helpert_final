import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';
import '../../../constants/api_endpoints.dart';
import '../../auth/repo/auth_repo.dart';

class CreatorProfileWidget extends StatelessWidget {
  const CreatorProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AuthRepo.instance.user.image.isEmpty
            ? Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                width: 100,
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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            '$VIDEO_BASE_URL${AuthRepo.instance.user.image}'))),
              ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          height: 102,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(
                  '${AuthRepo.instance.user.firstName} ${AuthRepo.instance.user.lastName}',
                  style: TextStyles.boldTextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(
                  AuthRepo.instance.user.specialization,
                  style: TextStyles.semiBoldTextStyle(
                      textColor: AppColors.acmeBlue),
                ),
              ),
              Center(
                child: RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 20,
                  initialRating: AuthRepo.instance.user.rating,
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
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    AuthRepo.instance.user.location,
                    style: TextStyles.regularTextStyle(
                      textColor: AppColors.moon,
                      fontSize: 14,
                    ).copyWith(height: 1.7),
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
