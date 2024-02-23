import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/constants/consts.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/book_call/screens/payment_screen.dart';
import 'package:helpert_app/features/book_call/widget/offer_widget.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../common_widgets/bottons/custom_elevated_button.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/scroll_behavior.dart';

class OfferingScreen extends StatelessWidget {
  final String appointmentDescription;
  final int sessionRate;
  final int doctorId;
  final String doctorImage;
  final int slotId;
  final int dayId;
  final String date;
  const OfferingScreen(
      {Key? key,
      required this.sessionRate,
      required this.doctorImage,
      required this.doctorId,
      required this.appointmentDescription,
      required this.slotId,
      required this.dayId,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('heloo');
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: AppColors.silver,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              width: double.infinity,
              child: CustomElevatedButton(
                onTap: () {
                  NavRouter.push(
                      context,
                      PaymentScreen(
                        appointmentDescription: appointmentDescription,
                        sessionRate: sessionRate,
                        doctorId: doctorId,
                        slotId: slotId,
                        dayId: dayId,
                        date: date,
                      ));
                },
                title: 'Continue',
              ),
            ),
          ],
        ),
      ),
      appBar: CustomAppBar(
        title: '',
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                doctorImage.isNotEmpty
                    ? Hero(
                        tag: doctorId,
                        child: CircleAvatar(
                          backgroundColor: AppColors.acmeBlue,
                          backgroundImage:
                              CachedNetworkImageProvider(APP_URL + doctorImage),
                          radius: 70,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: AppColors.acmeBlue,
                        backgroundImage:
                            AssetImage('assets/images/png/no_profile.png'),
                        radius: 70,
                      ),
                SizedBox(
                  height: 24,
                ),
                TextView(
                  'An offering',
                  textStyle: TextStyles.mediumTextStyle(
                    fontSize: 24,
                    textColor: Color(0xFF1D1E20),
                  ),
                ),
                TextView(
                  'Here’s what it’s all about',
                  textStyle: TextStyles.regularTextStyle(
                    fontSize: 16,
                    fontFamily: proximaFamily,
                    textColor: Color(0xFF1D1E20),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 40),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.silver),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          OfferWidget(
                            text: '30mins private video call',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          OfferWidget(text: 'Lifetime free chat'),
                          SizedBox(
                            height: 8,
                          ),
                          OfferWidget(text: 'Get expert’s advice'),
                          SizedBox(
                            height: 8,
                          ),
                          OfferWidget(text: 'Cancel any time '),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            color: AppColors.silver,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextView(
                            'Pricing detail',
                            textStyle: TextStyles.mediumTextStyle(
                              fontSize: 20,
                              textColor: Color(0xFF1D1E20),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextView(
                            '\$$sessionRate appointment charge',
                            textStyle: TextStyles.regularTextStyle(
                              fontSize: 16,
                              fontFamily: proximaFamily,
                              textColor: Color(0xFF1D1E20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 70,
                      right: 70,
                      top: -16,
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F6F7),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        alignment: Alignment.center,
                        child: TextView(
                          'Appointment',
                          textStyle: TextStyles.mediumTextStyle(
                            fontSize: 12,
                            textColor: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
