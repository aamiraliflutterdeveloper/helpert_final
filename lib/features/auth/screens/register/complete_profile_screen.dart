import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/textfield/custom_textformfield.dart';
import 'package:helpert_app/common_widgets/textfield/date_textformfield.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/date_formatter.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import 'specialization_detail_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  const CompleteProfileScreen({Key? key, this.firstName, this.lastName})
      : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final completeFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String? dateError;
  bool disable = true;
  bool obscureSetPasswordText = true;
  bool obscureConfirmPasswordText = true;
  bool? hasSpace;

  @override
  void initState() {
    if (widget.firstName != null && widget.lastName != null) {
      firstNameController.text = widget.firstName!;
      lastNameController.text = widget.lastName!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.pureWhite,
      body: Form(
        key: completeFormKey,
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
                      'Complete your Profile',
                      style: TextStyles.boldTextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Let us now who is you & don’t worry, your account will be safe.',
                      style: TextStyles.regularTextStyle(
                          fontSize: 14, textColor: AppColors.moon),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      labelText: 'Username',
                      errorMessage: context
                          .read<AuthBloc>()
                          .userNameValidation(usernameController.text),
                      onChanged: (val) {
                        if (context.read<AuthBloc>().userNameValidation(
                                    usernameController.text) ==
                                null &&
                            firstNameController.text.isNotEmpty &&
                            usernameController.text.isNotEmpty &&
                            lastNameController.text.isNotEmpty &&
                            dateController.text.isNotEmpty) {
                          setState(() {
                            disable = false;
                          });
                        } else {
                          setState(() {
                            disable = true;
                          });
                        }
                      },
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      controller: firstNameController,
                      errorMessage: context
                          .read<AuthBloc>()
                          .firstNameValidation(firstNameController.text),
                      labelText: 'First Name',
                      onChanged: (val) {
                        if (context.read<AuthBloc>().firstNameValidation(
                                    firstNameController.text) ==
                                null &&
                            firstNameController.text.isNotEmpty &&
                            usernameController.text.isNotEmpty &&
                            lastNameController.text.isNotEmpty &&
                            dateController.text.isNotEmpty) {
                          setState(() {
                            disable = false;
                          });
                        } else {
                          setState(() {
                            disable = true;
                          });
                        }
                      },
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      controller: lastNameController,
                      labelText: 'Last name',
                      errorMessage: context
                          .read<AuthBloc>()
                          .firstNameValidation(lastNameController.text),
                      onChanged: (val) {
                        if (context.read<AuthBloc>().lastNameValidation(
                                    lastNameController.text) ==
                                null &&
                            firstNameController.text.isNotEmpty &&
                            usernameController.text.isNotEmpty &&
                            lastNameController.text.isNotEmpty &&
                            dateController.text.isNotEmpty) {
                          setState(() {
                            disable = false;
                          });
                        } else {
                          setState(() {
                            disable = true;
                          });
                        }
                      },
                    ),
                    DateTextFormField(
                      errorMessage: dateError,
                      keyboardType: TextInputType.text,
                      controller: dateController,
                      labelText: 'When’s your birthday?',
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        String? date =
                            (await DateFormatter.pickDateDialog(context));
                        if (date != null) {
                          if (DateFormatter.is10YearsOld(date)) {
                            dateController.text = date;
                            if (firstNameController.text.isNotEmpty &&
                                usernameController.text.isNotEmpty &&
                                lastNameController.text.isNotEmpty &&
                                dateController.text.isNotEmpty) {
                              disable = false;
                            }
                            setState(() {
                              dateError = null;
                            });
                          } else {
                            setState(() {
                              dateError =
                                  'You must be at-least 10 years old to continue';
                            });
                          }
                        }
                      },
                    ),
                  ],
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
                                const SpecializationDetailScreen(
                                  beforeRegistration: true,
                                ));
                          }
                          if (state is AuthError) {
                            BotToast.closeAllLoading();
                            BotToast.showText(text: state.error);
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            onTap: () {
                              if (completeFormKey.currentState!.validate()) {
                                disable = true;
                              } else {
                                disable = false;
                              }
                              setState(() {});
                              context.read<AuthBloc>().completeProfile(
                                  usernameController.text.trim(),
                                  firstNameController.text.trim(),
                                  lastNameController.text.trim(),
                                  dateController.text.trim());
                            },
                            disable: disable,
                            title: 'Next',
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
}
