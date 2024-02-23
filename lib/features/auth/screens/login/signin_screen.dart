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
import 'package:helpert_app/dashboard_screen.dart';
import 'package:helpert_app/features/auth/bloc/auth_bloc.dart';
import 'package:helpert_app/features/auth/bloc/auth_state.dart';
import 'package:helpert_app/features/auth/models/social_user_model.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/auth/screens/register/specialization_detail_screen.dart';
import 'package:helpert_app/features/auth/widgets/auth_richtext.dart';
import 'package:helpert_app/features/auth/widgets/divider_with_text_widget.dart';
import 'package:helpert_app/features/auth/widgets/social_auth_button_row_widget.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../linkedin_auth.dart';
import '../register/complete_profile_screen.dart';
import '../register/register_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool disable = true;
  bool obscurePasswordText = true;
  String? emailErrorMessage;
  String? passwordErrorMessage;

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
          key: loginFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 62,
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyles.boldTextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'We’re happy to see. You can Login and continue consulting your problem or read some tips.',
                        style: TextStyles.regularTextStyle(
                            fontSize: 13, textColor: AppColors.moon),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        labelText: 'Email or Username',
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                      PasswordTextFormField(
                        controller: passwordController,
                        errorMessage: context
                            .read<AuthBloc>()
                            .passwordValidation(passwordController.text),
                        labelText: 'Password',
                        onChanged: (val) {
                          setState(() {});
                        },
                        showHidePassword: () {
                          setState(() {
                            obscurePasswordText = !obscurePasswordText;
                          });
                        },
                        obscureText: obscurePasswordText,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const ResetPasswordScreen()));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyles.semiBoldTextStyle(
                                fontSize: 14, textColor: AppColors.acmeBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeInUp(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoading ||
                                state is SocialAuthLoading) {
                              BotToast.showLoading();
                            } else if (state is AuthLoaded) {
                              BotToast.closeAllLoading();
                              if (AuthRepo.instance.getStep() == '0') {
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
                              } else if (AuthRepo.instance.getStep() == '1') {
                                NavRouter.push(
                                    context,
                                    SpecializationDetailScreen(
                                      beforeRegistration: true,
                                    ));
                              } else {
                                NavRouter.pushAndRemoveUntil(
                                    context, DashBoardScreen());
                              }
                            } else if (state is AuthError) {
                              BotToast.closeAllLoading();
                              BotToast.showText(text: state.error);
                            } else if (state is SocialError) {
                              BotToast.closeAllLoading();
                              BotToast.showText(text: state.error);
                            }
                          },
                          child: CustomElevatedButton(
                            onTap: () {
                              if (emailController.text.contains(' ')) {
                                BotToast.showText(
                                    text:
                                        "Email or Username don't\t have whitespace");
                              } else {
                                context.read<AuthBloc>().login(
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                            disable: (emailController.text.isEmpty ||
                                passwordController.text.isEmpty),
                            title: 'Sign In',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DividerWithTextWidget(text: 'or Sign in with'),
                      const SizedBox(
                        height: 20,
                      ),
                      SocialAuthButtonRowWidget(
                        onGoogleTap: () {
                          _socialFunc('GOOGLE', 1);
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
                        text: 'I don’t have an account ',
                        coloredText: 'Sign Up',
                        onTap: () {
                          NavRouter.pushReplacement(
                              context, const RegisterScreen());
                        },
                      ),
                      SizedBox(
                        height: Platform.isIOS ? 8 : 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
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
