import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

import 'models/social_user_model.dart';

class LinkedinAuth extends StatefulWidget {
  final int type;
  const LinkedinAuth({Key? key, required this.type}) : super(key: key);

  @override
  State<LinkedinAuth> createState() => _LinkedinAuthState();
}

class _LinkedinAuthState extends State<LinkedinAuth> {
  final String redirectUrl =
      'https://www.linkedin.com/developers/tools/oauth/redirect/';
  final String clientId = '77n5lx8k98oddi';
  final String clientSecret = 'V1cnmFhpUGwuajjE';

  late SocialUserModel socialUserModel;

  @override
  Widget build(BuildContext context) {
    return LinkedInUserWidget(
      redirectUrl: redirectUrl,
      clientId: clientId,
      clientSecret: clientSecret,
      onGetUserProfile: (UserSucceededAction linkedInUser) {
        socialUserModel = SocialUserModel(
          type: widget.type,
          firstName: '${linkedInUser.user.firstName?.localized?.label}',
          lastName: '${linkedInUser.user.lastName?.localized?.label}',
          uuid: linkedInUser.user.userId ?? '',
          fullName:
              '${linkedInUser.user.firstName?.localized?.label} ${linkedInUser.user.lastName?.localized?.label}',
          imageUrl: '',
          provider: 'LINKEDIN',
          email:
              linkedInUser.user.email?.elements?[0].handleDeep?.emailAddress ??
                  '',
          fcmToken: 'fcmToken',
        );

        Navigator.pop(context, socialUserModel);
      },
      onError: (UserFailedAction e) {
        Navigator.pop(context, 'error');
      },
    );
  }
}
