import 'package:flutter/material.dart';

import '../../../../common_widgets/cancel_publisher_topbar.dart';
import '../widgets/update_congratulation_card.dart';

class CongratulationScreenForUpdate extends StatefulWidget {
  const CongratulationScreenForUpdate({Key? key}) : super(key: key);

  @override
  State<CongratulationScreenForUpdate> createState() =>
      _CongratulationScreenForUpdateState();
}

class _CongratulationScreenForUpdateState
    extends State<CongratulationScreenForUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: const [
          SizedBox(height: 40),
          CancelPublishTopBar(),
          UpdateCongratulationCard(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
