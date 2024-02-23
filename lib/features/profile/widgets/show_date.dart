import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/text_styles.dart';

class JoinedDateWidget extends StatelessWidget {
  const JoinedDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.5),
          child:
              SvgImage(path: 'assets/images/svg/ic_calendar.svg', height: 14),
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
          child: Text(AuthRepo.instance.user.joining_date,
              style: TextStyles.regularTextStyle(
                  textColor: AppColors.black, fontSize: 12)),
        )
      ],
    );
  }
}
