import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common_widgets/components/custom_appbar.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/nav_router.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help Center',
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
              initialUrl: 'https://helppert.com/contact-us/',
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
