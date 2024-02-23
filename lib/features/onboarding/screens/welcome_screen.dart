import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/auth/bloc/auth_state.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../dashboard_screen.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/linkedin_auth.dart';
import '../../auth/models/social_user_model.dart';
import '../../auth/repo/auth_repo.dart';
import '../../auth/screens/login/signin_screen.dart';
import '../../auth/screens/register/complete_profile_screen.dart';
import '../../auth/screens/register/register_screen.dart';
import '../../auth/widgets/social_auth_button_row_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 74,
                    ),
                    Text(
                      'Welcome to Helpert!',
                      style: TextStyles.boldTextStyle(fontSize: 43),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Here we will connect you with experts or specialists, Recruiters and job seekers in various fields, so you can get consultation or career advice via videocall. You can also become Expert to help people around by giving advice and earn money.',
                      style: TextStyles.regularTextStyle(
                          fontSize: 14, textColor: AppColors.moon),
                    ),
                  ],
                ),
              ),
              FadeInUp(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          NavRouter.pushReplacement(
                              context, const RegisterScreen());
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: AppColors.acmeBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: Text(
                          'Create an Account',
                          style: TextStyles.semiBoldTextStyle(
                              textColor: AppColors.pureWhite),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.silver,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'or Sign Up with',
                          style: TextStyles.regularTextStyle(
                              fontSize: 12, textColor: AppColors.moon),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.silver,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoading || state is SocialAuthLoading) {
                          BotToast.showLoading();
                        } else if (state is AuthLoaded) {
                          BotToast.closeAllLoading();
                          if (AuthRepo.instance.getStep() == '0') {
                            NavRouter.push(
                                context,
                                CompleteProfileScreen(
                                  firstName:
                                      context.read<AuthBloc>().socialUserModel !=
                                              null
                                          ? context
                                              .read<AuthBloc>()
                                              .socialUserModel!
                                              .firstName
                                          : null,
                                  lastName:
                                      context.read<AuthBloc>().socialUserModel !=
                                              null
                                          ? context
                                              .read<AuthBloc>()
                                              .socialUserModel!
                                              .lastName
                                          : null,
                                ));
                          } else if (AuthRepo.instance.getStep() == '1' ||
                              AuthRepo.instance.getStep() == '2') {
                            NavRouter.pushAndRemoveUntil(
                                context, const DashBoardScreen());
                          }
                        } else if (state is AuthError) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: state.error);
                        }
                      },
                      child: SocialAuthButtonRowWidget(
                        onGoogleTap: () {
                          _socialFunc('GOOGLE', 0);
                        },
                        onLinkedinTap: () async {
                          final result = await NavRouter.push(
                              context,
                              LinkedinAuth(
                                type: 0,
                              ));
                          if (result == 'error') {
                            Fluttertoast.showToast(
                                msg: 'Error, Please try again');
                          } else {
                            context.read<AuthBloc>().socialUserModel =
                                (result as SocialUserModel);
                            context.read<AuthBloc>().socialLogin();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'I already have an account ',
                        style: TextStyles.regularTextStyle(
                            fontSize: 14, textColor: AppColors.moon),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyles.semiBoldTextStyle(
                                fontSize: 14, textColor: AppColors.acmeBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                NavRouter.pushReplacement(
                                    context, const LoginScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _socialFunc(String provider, int type) async {
    bool result =
        await context.read<AuthBloc>().fetchSocialAuthData(provider, type);
    if (result) {
      await context.read<AuthBloc>().socialLogin();
    }
  }
}
