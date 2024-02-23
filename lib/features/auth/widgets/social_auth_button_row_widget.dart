import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/bottons/social_auth_button.dart';
import 'package:helpert_app/constants/asset_paths.dart';

class SocialAuthButtonRowWidget extends StatelessWidget {
  const SocialAuthButtonRowWidget({
    Key? key,
    required this.onGoogleTap,
    required this.onLinkedinTap,
  }) : super(key: key);

  final VoidCallback onGoogleTap;
  final VoidCallback onLinkedinTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialAuthButton(
          icon: ic_linkedin,
          onTap: onLinkedinTap,
        ),
        const SizedBox(
          width: 30,
        ),
        SocialAuthButton(
          height: 58,
          width: 58,
          icon: ic_google,
          onTap: onGoogleTap,
          innerPadding: 4.5,
        ),
      ],
    );
  }
}
