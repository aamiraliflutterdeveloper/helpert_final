import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';

class CommonTile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String image;
  final String timeAgo;
  final String description;
  final bool isRead;
  final VoidCallback callBack;

  const CommonTile({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.callBack,
    required this.timeAgo,
    required this.description,
    required this.isRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isRead ? AppColors.pureWhite : AppColors.snow,
          boxShadow: [
            BoxShadow(
              color: isRead
                  ? AppColors.silver.withOpacity(.4)
                  : AppColors.pureWhite.withOpacity(.4),
              blurRadius: 8,
              spreadRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: image.isNotEmpty
                          ? DecorationImage(
                              image:
                                  CachedNetworkImageProvider(APP_URL + image),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage(
                                  'assets/images/png/no_profile.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstName + " " + lastName,
                          style: TextStyles.semiBoldTextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          timeAgo,
                          style: TextStyles.regularTextStyle(
                              fontSize: 12, textColor: AppColors.moon),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          description,
                          style: TextStyles.regularTextStyle(
                              textColor: AppColors.moon, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
