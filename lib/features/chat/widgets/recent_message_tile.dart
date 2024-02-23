import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/utils/date_formatter.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';
import '../model/recent_chat_model.dart';

class RecentMessageTile extends StatelessWidget {
  final RecentChatModel model;

  const RecentMessageTile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.user.image == null
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('assets/images/png/no_profile.png'),
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(
                      VIDEO_BASE_URL + model.user.image!),
                ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${model.user.firstName} ${model.user.lastName}',
                      style: TextStyles.mediumTextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      '${DateFormatter.timeAgo(model.createdAt)} ago',
                      style: TextStyles.regularTextStyle(
                        textColor: AppColors.moon,
                        fontSize: 12,
                      ).copyWith(
                        height: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  model.message,
                  style: TextStyles.regularTextStyle(
                          fontSize: 13, textColor: AppColors.moon)
                      .copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: 1,
                  color: Colors.black.withOpacity(0.1),
                )
                // Divider(),
              ],
            ),
          ),
          // const Spacer(),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Text(
          //     //   model.createdAt.toString(),
          //     //   style: TextStyles.regularTextStyle(
          //     //       textColor: AppColors.moon, fontSize: 13),
          //     // ),
          //     // messageDetail.isRead == true
          //     //     ? Container(
          //     //         alignment: Alignment.center,
          //     //         height: 25,
          //     //         width: 25,
          //     //         decoration: BoxDecoration(
          //     //           color: AppColors.acmeBlue,
          //     //           borderRadius: BorderRadius.circular(25),
          //     //         ),
          //     //         child: Text(
          //     //           "1",
          //     //           style: TextStyles.mediumTextStyle(
          //     //             textColor: AppColors.pureWhite,
          //     //           ),
          //     //         ),
          //     //       )
          //     //     : const SizedBox(
          //     //         width: 25,
          //     //         height: 25,
          //     //       ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
