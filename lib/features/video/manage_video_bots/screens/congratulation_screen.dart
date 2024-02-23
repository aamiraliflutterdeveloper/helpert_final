import 'package:flutter/material.dart';

import '../../../../common_widgets/cancel_publisher_topbar.dart';
import '../widgets/congratulation_card.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: const [
          SizedBox(height: 40),
          CancelPublishTopBar(),
          CongratulationCard(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
