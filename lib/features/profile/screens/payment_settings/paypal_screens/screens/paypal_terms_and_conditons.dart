import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';

import '../../../../../../common_widgets/bottons/elevated_button_without_icon.dart';
import '../../../../../../common_widgets/components/custom_appbar.dart';
import '../../../../../../constants/text_styles.dart';
import '../widgets/terms_conditions_paragraph.dart';

class PaypalTermsAndConditions extends StatelessWidget {
  const PaypalTermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Login to Paypal',
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset(paypal_tc),
                  SizedBox(height: 15),
                  Text("Connect your Paypal account with Helpert Payment Page",
                      textAlign: TextAlign.center,
                      style: TextStyles.boldTextStyle(fontSize: 18)),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("This will allow Helpert Payment Page to :",
                        style: TextStyles.regularTextStyle(fontSize: 14)),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Receive personal information",
                        style: TextStyles.regularTextStyle(fontSize: 14)),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Full name, email, address, account verification status, Paypal ID",
                        style: TextStyles.regularTextStyle(
                            fontSize: 14, textColor: AppColors.moon)),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 1, color: AppColors.silver),
                  SizedBox(height: 10),
                  TermsConditionsParagraph(),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButtonWithoutIcon(
                      onPressed: () {},
                      text: 'Allow & Connect',
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButtonWithoutIcon(
                      onPressed: () {},
                      primaryColor: AppColors.snow,
                      borderColor: AppColors.snow,
                      textColor: AppColors.acmeBlue,
                      text: 'Decline',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
