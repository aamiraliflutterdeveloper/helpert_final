import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/prefs.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/core/data/onboarding_model.dart';
import 'package:helpert_app/features/onboarding/screens/welcome_screen.dart';
import 'package:helpert_app/features/onboarding/widgets/onboarding_data_widget.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/shared_preference_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
              controller: controller,
              itemCount: onboarding.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnBoardingDataWidget(
                  title: onboarding[index].title,
                  description: onboarding[index].description,
                  image: onboarding[index].image,
                );
              }),
          Positioned(
            bottom: Platform.isIOS ? 34 : 16,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboarding.length,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: AppColors.sky,
                        dotColor: AppColors.silver

                        // strokeWidth: 5,
                        ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: currentIndex == 2
                        ? FadeInUp(
                            child: SizedBox(
                              height: 42,
                              child: ElevatedButton(
                                onPressed: () {
                                  PreferenceManager.instance
                                      .setBool(Prefs.ONBOARDING_SEEN, true);
                                  NavRouter.pushReplacement(
                                      context, const WelcomeScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.acmeBlue,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                child: Text('Get Started',
                                    style: TextStyles.semiBoldTextStyle(
                                        textColor: AppColors.pureWhite)),
                              ),
                            ),
                          )
                        : FadeInLeft(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    PreferenceManager.instance
                                        .setBool(Prefs.ONBOARDING_SEEN, true);

                                    NavRouter.pushReplacement(
                                        context, const WelcomeScreen());
                                  },
                                  child: Text(
                                    'Skip',
                                    style: TextStyles.semiBoldTextStyle(
                                        textColor: AppColors.acmeBlue),
                                  ),
                                ),
                                SizedBox(
                                  height: 42,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.acmeBlue,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6))),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Next',
                                          style: TextStyles.semiBoldTextStyle(
                                              textColor: AppColors.pureWhite),
                                        ),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        SvgPicture.asset(ic_next)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
