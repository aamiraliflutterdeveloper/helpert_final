import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/bottons/elevated_button_without_icon.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../../../common_widgets/bottons/custom_elevated_button.dart';
import '../../../../../../common_widgets/components/custom_appbar.dart';
import '../../../../../../common_widgets/textfield/paypal_text_field.dart';
import '../../../../../../constants/asset_paths.dart';
import '../widgets/divider_widget.dart';
import 'paypal_terms_and_conditons.dart';

class LoginPaypalScreen extends StatefulWidget {
  const LoginPaypalScreen({Key? key}) : super(key: key);

  @override
  State<LoginPaypalScreen> createState() => _LoginPaypalScreenState();
}

class _LoginPaypalScreenState extends State<LoginPaypalScreen> {
  final controller = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.pureWhite,
        appBar: const CustomAppBar(
          title: 'Login to Paypal',
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Image.asset(paypal_image),
                  SizedBox(height: 10),
                  Text("Connect with paypal account",
                      style: TextStyles.regularTextStyle(fontSize: 14)),
                  SizedBox(height: 30),
                  PaypalTextFiled(
                    obscureText: false,
                    labelText: 'Type your email or phone number',
                    controller: emailController,
                    prefixIcon: Icons.email,
                  ),
                  PaypalTextFiled(
                    obscureText: _obscureText ? true : false,
                    onPressed: () {
                      _toggle();
                    },
                    labelText: 'Type your password',
                    controller: passwordController,
                    prefixIcon: Icons.lock,
                    suffixIcon:
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onTap: () {
                        NavRouter.push(context, PaypalTermsAndConditions());
                      },
                      disable: false,
                      title: 'Login',
                    ),
                  ),
                  SizedBox(height: 18),
                  DividerWidget(),
                  SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButtonWithoutIcon(
                      onPressed: () {},
                      primaryColor: AppColors.snow,
                      borderColor: AppColors.snow,
                      textColor: AppColors.acmeBlue,
                      text: 'Register',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
