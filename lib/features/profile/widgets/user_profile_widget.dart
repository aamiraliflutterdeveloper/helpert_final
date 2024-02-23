import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';
import '../../../constants/api_endpoints.dart';
import '../../auth/repo/auth_repo.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AuthRepo.instance.user.image.isEmpty
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
                            '$VIDEO_BASE_URL${AuthRepo.instance.user.image}'))),
              ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AuthRepo.instance.user.firstName} ${AuthRepo.instance.user.lastName}',
                style: TextStyles.boldTextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
