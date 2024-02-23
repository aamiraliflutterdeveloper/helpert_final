import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/bloc/payment_bloc.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/bloc/payment_state.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/screens/WebViewScreen.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../../common_widgets/components/custom_appbar.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../core/data/payment_settings_data_model.dart';
import '../widgets/payment_setting_tile.dart';

class PaymentSettingScreen extends StatefulWidget {
  const PaymentSettingScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSettingScreen> createState() => _PaymentSettingScreenState();
}

class _PaymentSettingScreenState extends State<PaymentSettingScreen> {
  bool disable = true;

  @override
  void initState() {
    context.read<PaymentBloc>().alreadyVisited = false;

    context
        .read<PaymentBloc>()
        .getStripeAccount(AuthRepo.instance.user.stripeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Payment Settings',
      ),
      body: BlocConsumer<PaymentBloc, PaymentState>(listener: (context, state) {
        if (state is PaymentAccountLinkLoaded) {
          NavRouter.push(
              context,
              WebViewScreen(
                url: state.stripeAccountLinkModel.url,
                title: 'Stripe Connect',
                color: 0xFF0261FE,
              )).then((value) {
            context.read<PaymentBloc>().getStripeAccount(
                  AuthRepo.instance.user.stripeId,
                );
          });
        }
      }, builder: (context, state) {
        return state is PaymentAccountLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Add payment method to receive",
                      style: TextStyles.regularTextStyle(
                          fontSize: 14, textColor: AppColors.moon),
                    ),
                  ),
                  const SizedBox(height: 16),

                  PaymentSettingTile(
                      accountModel: state.stripeAccountModel,
                      paymentSettings: PaymentSettingDataModel(
                          isVerified: state.stripeAccountModel.chargesEnabled,
                          image: stripeSvg,
                          title: 'Stripe',
                          subTitle: 'Connect with Stripe')),
                  // Expanded(
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: paymentSettingsList.length,
                  //     itemBuilder: (context, index) {
                  //       final PaymentSettingDataModel paymentSettings =
                  //           paymentSettingsList[index];
                  //       return PaymentSettingTile(paymentSettings: paymentSettings);
                  //     },
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Container(
                  //     color: AppColors.pureWhite,
                  //     width: double.infinity,
                  //     child: CustomElevatedButton(
                  //       onTap: () {},
                  //       disable: disable,
                  //       title: 'Next',
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 25),
                ],
              )
            : state is PaymentLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text('Please wait....'),
                  );
      }),
    );
  }
}
