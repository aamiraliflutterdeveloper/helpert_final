import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/nav_router.dart';

class BookingCongratulationScreen extends StatelessWidget {
  const BookingCongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Confirmation',
        automaticallyImplyLeading: false,
        onBackIconPress: () {
          NavRouter.pushToRoot(context);
        },
      ),
      body: WillPopScope(
        onWillPop: () {
          NavRouter.pushToRoot(context);
          return Future.value(true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: ZoomIn(
                child: SvgImage(
                  path: congrats_image,
                ),
              ),
            ),
            FadeInUp(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'Thank You!',
                      style: TextStyles.boldTextStyle(fontSize: 28),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please wait for a moment, we’ll\n notify you when Specialist\n approve your request.',
                      textAlign: TextAlign.center,
                      style: TextStyles.regularTextStyle(
                          fontSize: 16, textColor: AppColors.moon),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomElevatedButton(
                      title: 'Home',
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      onTap: () {
                    NavRouter.pushToRoot(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
