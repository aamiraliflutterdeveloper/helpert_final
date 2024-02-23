import 'package:flutter/material.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/prefs.dart';
import 'package:helpert_app/dashboard_screen.dart';
import 'package:helpert_app/features/auth/screens/login/signin_screen.dart';
import 'package:helpert_app/features/onboarding/screens/onboarding.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:helpert_app/utils/shared_preference_manager.dart';

import 'features/auth/repo/auth_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        bool isOnboardingSeen =
            PreferenceManager.instance.getBool(Prefs.ONBOARDING_SEEN);

        if (isOnboardingSeen == false) {
          NavRouter.pushReplacement(context, const OnBoardingScreen());
        } else {
          if (AuthRepo.instance.getStep() == '2' &&
              AuthRepo.instance.getToken() != '') {
            // init session
            await AuthRepo.instance.initiateAppLevelSession();
            NavRouter.pushAndRemoveUntil(context, DashBoardScreen());
          } else {
            NavRouter.pushAndRemoveUntil(context, const LoginScreen());
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(helpert_logo_square_png))),
                ),
                Positioned(
                    bottom: 130,
                    left: 0,
                    right: 0,
                    child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Helpert!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
