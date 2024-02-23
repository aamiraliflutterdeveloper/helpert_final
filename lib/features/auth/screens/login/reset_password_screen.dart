import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/textfield/custom_textformfield.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

import 'create_new_password_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool disable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.pureWhite,
      body: Form(
        key: formKey,
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
                      'Reset Password',
                      style: TextStyles.boldTextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Please enter your email or username you signed up with. We’ll immediately send Reset link',
                      style: TextStyles.regularTextStyle(
                          fontSize: 14, textColor: AppColors.moon),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      labelText: 'Type your email',
                      onChanged: (val) {
                        if (val.isValidEmail()) {
                          setState(() {
                            disable = false;
                          });
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
                      child: CustomElevatedButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CreateNewPasswordScreen()));
                        },
                        disable: disable,
                        title: 'Send',
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

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
