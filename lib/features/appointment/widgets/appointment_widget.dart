import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/appointment/widgets/call_status_richtext.dart';

import '../../../constants/api_endpoints.dart';

class AppointmentWidget extends StatelessWidget {
  final String name;
  final String? image;
  final String callStatus;
  final String callSTime;
  final String callETime;
  final VoidCallback forwardArrowCallback;

  const AppointmentWidget({
    Key? key,
    required this.name,
    required this.callStatus,
    required this.image,
    required this.callSTime,
    required this.callETime,
    required this.forwardArrowCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        shadowColor: AppColors.shadowColor,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image == null
                  ? CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          AssetImage('assets/images/png/no_profile.png'),
                    )
                  : CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          CachedNetworkImageProvider('$VIDEO_BASE_URL$image'),
                    ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyles.mediumTextStyle(
                                fontSize: 16, textColor: AppColors.coal),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          CallStatusRichText(
                            callback: forwardArrowCallback,
                            text: 'Video call',
                            coloredText: callStatus,
                            textColor: callStatus == 'Scheduled'
                                ? AppColors.acmeBlue
                                : callStatus == 'Completed'
                                    ? AppColors.success
                                    : callStatus == 'Declined'
                                        ? AppColors.failure
                                        : AppColors.warning,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '$callSTime - $callETime',
                            style: TextStyles.regularTextStyle(
                                fontSize: 14, textColor: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: forwardArrowCallback,
                        icon: const SvgImage(
                          path: ic_arrow_forward_ios,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
