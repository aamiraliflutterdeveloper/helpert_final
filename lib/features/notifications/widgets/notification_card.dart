import 'package:flutter/material.dart';

import '../../../common_widgets/fetch_svg.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/asset_paths.dart';
import '../../../constants/text_styles.dart';

class NotificationCard extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String description;
  final bool isRead;
  final VoidCallback callBack;
  final String icon;

  const NotificationCard({
    Key? key,
    required this.userName,
    required this.callBack,
    required this.timeAgo,
    required this.description,
    required this.isRead,
    this.icon = notifyTimeIcon,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFEEF4FF),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(13.0),
                  child: SvgImage(
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                    path: icon,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: TextStyles.semiBoldTextStyle(fontSize: 14)),
                    SizedBox(
                      height: 6,
                    ),
                    Text(timeAgo,
                        style: TextStyles.regularTextStyle(
                            fontSize: 12, textColor: AppColors.moon)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(description,
                        style: TextStyles.regularTextStyle(
                            textColor: AppColors.moon, fontSize: 14))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
