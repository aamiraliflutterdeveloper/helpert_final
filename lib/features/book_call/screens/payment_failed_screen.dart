import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../constants/asset_paths.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment',
        hasElevation: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFFF3B30),
                child: SvgImage(
                  path: ic_failed_payment,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Payment failed',
                textAlign: TextAlign.center,
                style: TextStyles.mediumTextStyle(
                  fontSize: 24,
                  textColor: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Not enough money on the card',
                textAlign: TextAlign.center,
                style: TextStyles.regularTextStyle(
                  fontSize: 17,
                  textColor: Color(0xFF4D4D4D),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  NavRouter.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgImage(
                      path: ic_backbutton,
                      color: Color(0xFF007AFF),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextView(
                      'Pay with another card',
                      textStyle: TextStyles.mediumTextStyle(
                        fontSize: 15,
                        textColor: Color(0xFF007AFF),
                      ),
                    ),
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
