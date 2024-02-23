import 'package:flutter/material.dart';

import '../../../common_widgets/fetch_svg.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';

class NotificationTile extends StatelessWidget {
  final bool checkDetails;
  final String title;
  final String icon;
  const NotificationTile({
    required this.checkDetails,
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.snow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                            color: AppColors.pureWhite,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgImage(
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                                path: icon))),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(title,
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyles.semiBoldTextStyle(fontSize: 14)),
                        ),
                        Text("1 Hours ago",
                            style: TextStyles.regularTextStyle(
                                fontSize: 14, textColor: AppColors.moon)),
                      ],
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.more_vert, color: AppColors.moon),
                    )
                  ],
                ),
                checkDetails == true
                    ? Padding(
                        padding: const EdgeInsets.only(right: 21.0),
                        child: Text(
                          "Check details here.",
                          style: TextStyles.regularTextStyle(
                              textColor: AppColors.moon),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
