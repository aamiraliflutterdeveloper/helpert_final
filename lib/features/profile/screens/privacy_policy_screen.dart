import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common_widgets/components/custom_appbar.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/nav_router.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Privacy Policy',
        hasElevation: true,
        onBackIconPress: () {
          NavRouter.pop(context);
        },
      ),
      body: Column(
        children: [
          Visibility(
            visible: progress < 1,
            maintainState: true,
            maintainSize: true,
            maintainAnimation: true,
            child: LinearProgressIndicator(
              backgroundColor: AppColors.nickel.withOpacity(0.5),
              value: progress,
            ),
          ),
          Expanded(
            child: WebView(
              initialUrl: 'https://helppert.com/privacy-policy/',
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (value) {
                setState(() {
                  progress = value / 100;
                  debugPrint('pg :: $progress');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
