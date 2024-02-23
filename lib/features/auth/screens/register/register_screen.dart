import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/textfield/custom_textformfield.dart';
import 'package:helpert_app/common_widgets/textfield/password_textformfield.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/auth/widgets/auth_richtext.dart';
import 'package:helpert_app/features/auth/widgets/divider_with_text_widget.dart';
import 'package:helpert_app/features/auth/widgets/social_auth_button_row_widget.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import '../../linkedin_auth.dart';
import '../../models/social_user_model.dart';
import '../login/signin_screen.dart';
import 'complete_profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool disable = true;
  bool obscureSetPasswordText = true;
  bool obscureConfirmPasswordText = true;
  String? emailError;
  String? userNameError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Form(
          key: registerFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: FadeInDown(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 62,
                          ),
                          Text(
                            'Create an Account',
                            style: TextStyles.boldTextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Create an account so you can use Helpert!',
                            style: TextStyles.regularTextStyle(
                                fontSize: 14, textColor: AppColors.moon),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          CustomTextFormField(
                            errorMessage: context
                                .read<AuthBloc>()
                                .emailValidation(emailController.text),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            labelText: 'Email',
                            onChanged: (val) {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                disable = false;
                              }
                              setState(() {});
                            },
                          ),
                          PasswordTextFormField(
                            errorMessage: context
                                .read<AuthBloc>()
                                .passwordValidation(passwordController.text),
                            controller: passwordController,
                            labelText: 'Password',
                            onChanged: (val) {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                disable = false;
                              }
                              setState(() {});
                            },
                            obscureText: obscureSetPasswordText,
                            showHidePassword: () {
                              setState(() {
                                obscureSetPasswordText =
                                    !obscureSetPasswordText;
                              });
                            },
                          ),
                          PasswordTextFormField(
                            errorMessage: confirmPasswordError,
                            controller: confirmPasswordController,
                            obscureText: obscureConfirmPasswordText,
                            showHidePassword: () {
                              setState(() {
                                obscureConfirmPasswordText =
                                    !obscureConfirmPasswordText;
                              });
                            },
                            labelText: 'Confirm password',
                            onChanged: (val) {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                disable = false;
                              }
                              setState(() {
                                confirmPasswordError = null;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                          if (state is AuthLoading ||
                              state is SocialAuthLoading) {
                            BotToast.showLoading();
                          }
                          if (state is AuthLoaded) {
                            BotToast.closeAllLoading();
                            NavRouter.push(
                                context,
                                CompleteProfileScreen(
                                  firstName: context
                                              .read<AuthBloc>()
                                              .socialUserModel !=
                                          null
                                      ? context
                                          .read<AuthBloc>()
                                          .socialUserModel!
                                          .firstName
                                      : null,
                                  lastName: context
                                              .read<AuthBloc>()
                                              .socialUserModel !=
                                          null
                                      ? context
                                          .read<AuthBloc>()
                                          .socialUserModel!
                                          .lastName
                                      : null,
                                ));
                          }
                          if (state is AuthError) {
                            BotToast.closeAllLoading();
                            BotToast.showText(text: state.error);
                          } else if (state is SocialError) {
                            BotToast.closeAllLoading();
                            BotToast.showText(text: state.error);
                          }
                        }, builder: (context, state) {
                          return CustomElevatedButton(
                            onTap: () {
                              if (confirmPasswordController.text.trim() ==
                                  passwordController.text.trim()) {
                                context.read<AuthBloc>().signUp(
                                    emailController.text,
                                    passwordController.text);
                              } else {
                                setState(() {
                                  confirmPasswordError =
                                      'Password doesn\'t match';
                                });
                              }
                            },
                            disable: disable,
                            title: 'Next',
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DividerWithTextWidget(
                        text: 'or Sign Up with',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SocialAuthButtonRowWidget(
                        onGoogleTap: () async {
                          await _socialFunc('GOOGLE', 0);
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
                      const SizedBox(
                        height: 20,
                      ),
                      AuthRichText(
                        text: 'I already have an account ',
                        coloredText: 'Sign In',
                        onTap: () {
                          NavRouter.pushReplacement(
                              context, const LoginScreen());
                        },
                      ),
                      SizedBox(
                        height: Platform.isIOS ? 8 : 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _socialFunc(String provider, int type) async {
    bool result =
        await context.read<AuthBloc>().fetchSocialAuthData(provider, type);
    if (result) {
      await context.read<AuthBloc>().socialLogin();
    }
  }
}
