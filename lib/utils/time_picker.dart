import 'package:flutter/material.dart';

selectTime(BuildContext context) async {
  TimeOfDay selectedTime = TimeOfDay.now();
  final TimeOfDay? timeOfDay = await showTimePicker(
    context: context,
    initialTime: selectedTime,
    initialEntryMode: TimePickerEntryMode.dial,
    onEntryModeChanged: (value) {},
  );
  if (timeOfDay != null && timeOfDay != selectedTime) {
    selectedTime = timeOfDay;
  }
  return selectedTime;
}
