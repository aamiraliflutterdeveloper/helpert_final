import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';
import '../../../common_widgets/fetch_svg.dart';
import '../../auth/models/user_model.dart';

class OtherUserJoinedDateWidget extends StatelessWidget {
  final UserModel user;

  const OtherUserJoinedDateWidget({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.5),
          child: SvgImage(
            path: 'assets/images/svg/ic_calendar.svg',
            height: 14,
          ),
        ),
        const SizedBox(width: 7),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text('Joined, ',
              style: TextStyles.regularTextStyle(
                  textColor: AppColors.moon, fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(user.joining_date,
              style: TextStyles.regularTextStyle(
                  textColor: AppColors.black, fontSize: 12)),
        )
      ],
    );
  }
}
