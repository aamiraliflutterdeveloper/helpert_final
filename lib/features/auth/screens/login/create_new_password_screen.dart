import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/textfield/password_textformfield.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/nav_router.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController setPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool disable = true;
  bool obscureSetPasswordText = true;
  bool obscureConfirmPasswordText = true;
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
                      'Create New Password',
                      style: TextStyles.boldTextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Yay! your password was Reset. And now you can create a new password.',
                      style: TextStyles.regularTextStyle(
                          fontSize: 14, textColor: AppColors.moon),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    PasswordTextFormField(
                      obscureText: obscureSetPasswordText,
                      showHidePassword: () {
                        setState(() {
                          obscureSetPasswordText = !obscureSetPasswordText;
                        });
                      },
                      controller: setPasswordController,
                      labelText: 'Set new password',
                      onChanged: (val) {
                        if (setPasswordController.text.isNotEmpty &&
                            setPasswordController.text.isNotEmpty) {
                          setState(() {
                            disable = false;
                          });
                        }
                      },
                    ),
                    PasswordTextFormField(
                      obscureText: obscureConfirmPasswordText,
                      showHidePassword: () {
                        setState(() {
                          obscureConfirmPasswordText =
                              !obscureConfirmPasswordText;
                        });
                      },
                      controller: confirmPasswordController,
                      labelText: 'Confirm password',
                      onChanged: (val) {
                        if (setPasswordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty) {
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
                          NavRouter.pushToRoot(context);
                        },
                        disable: disable,
                        title: 'Save & Sign In',
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
