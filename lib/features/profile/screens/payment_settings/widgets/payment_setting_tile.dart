import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/model/stripe_aacount_model.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../core/data/payment_settings_data_model.dart';
import '../bloc/payment_bloc.dart';

class PaymentSettingTile extends StatelessWidget {
  final PaymentSettingDataModel paymentSettings;
  final StripeAccountModel accountModel;

  const PaymentSettingTile({
    Key? key,
    required this.paymentSettings,
    required this.accountModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        paymentSettings.isVerified
            ? () {}
            : context
                .read<PaymentBloc>()
                .createStripeAccountLink(accountModel.id);
      },
      child: ListTile(
        leading: Padding(
            padding: EdgeInsets.only(top: 8),
            child: SvgImage(path: paymentSettings.image)),
        title: Text(paymentSettings.title,
            style: TextStyles.mediumTextStyle(fontSize: 16)),
        subtitle: Text(
            paymentSettings.isVerified
                ? accountModel.email
                : paymentSettings.subTitle,
            style: TextStyles.mediumTextStyle(
                fontSize: 14, textColor: AppColors.moon)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // paymentSettings.isVerified
            //     ? Text('Verified')
            //     : Text('Not verified yet'),
            // SizedBox(width: 10),
            Icon(paymentSettings.isVerified ? Icons.verified : Icons.info,
                color: paymentSettings.isVerified
                    ? AppColors.success
                    : AppColors.failure),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios_outlined, size: 15)
          ],
        ),
      ),
    );
  }
}
