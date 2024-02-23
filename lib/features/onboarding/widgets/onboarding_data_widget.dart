import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class OnBoardingDataWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnBoardingDataWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInDown(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .55,
            child: Image.asset(image),
          ),
        ),
        FadeInUp(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .45,
            child: Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                Text(
                  title,
                  style: TextStyles.boldTextStyle(fontSize: 28),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    description,
                    style: TextStyles.regularTextStyle(
                      textColor: AppColors.moon,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
