import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';

import '../../../../../constants/app_colors.dart';

class ToggleSwitch extends StatefulWidget {
  final bool switchValue;
  final DaysListModel days;
  final int dayIndex;
  final VoidCallback toggleCallBack;
  const ToggleSwitch(
      {Key? key,
      required this.switchValue,
      required this.days,
      required this.dayIndex,
      required this.toggleCallBack})
      : super(key: key);
  @override
  SwitchClass createState() => SwitchClass(
      isSwitched: switchValue,
      dayIndex: dayIndex,
      days: days,
      toggleCallBack: toggleCallBack);
}

class SwitchClass extends State {
  bool isSwitched;
  DaysListModel days;
  int dayIndex;
  final VoidCallback toggleCallBack;
  var textValue = 'Switch is OFF';

  SwitchClass({
    required this.days,
    required this.dayIndex,
    required this.isSwitched,
    required this.toggleCallBack,
  });

  void toggleSwitch(bool value) {
    if (days.days[dayIndex].bookingStatus == 0) {
      toggleCallBack();
      if (isSwitched == false) {
        setState(() {
          isSwitched = true;
          days.days[dayIndex].status = 1;
          textValue = 'Switch Button is ON';
        });
      } else {
        setState(() {
          isSwitched = false;
          days.days[dayIndex].status = 0;
          textValue = 'Switch Button is OFF';
        });
      }
    } else {
      BotToast.showText(text: 'Day can\'t be off due to appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.1,
          child: Switch(
              onChanged: toggleSwitch,
              value: isSwitched,
              activeColor: AppColors.acmeBlue,
              activeTrackColor: Colors.blue.shade100,
              inactiveThumbColor: Colors.redAccent,
              inactiveTrackColor: Colors.orange)),
    ]);
  }
}
