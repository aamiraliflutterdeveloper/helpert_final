import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';
import 'package:helpert_app/features/profile/screens/schedule/widgets/time_slot_widget.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/text_styles.dart';
import 'toggle_switch.dart';

class DaysAvailabilityTile extends StatefulWidget {
  final String day;
  final int dayIndex;
  final bool dayValue;
  final List<SlotModel> timeSlots;
  final DaysListModel days;
  final Function(List<SlotModel>) callBack;
  final VoidCallback toggleCallBack;

  const DaysAvailabilityTile(
      {Key? key,
      required this.day,
      required this.dayValue,
      required this.timeSlots,
      required this.callBack,
      required this.days,
      required this.dayIndex,
      required this.toggleCallBack})
      : super(key: key);

  @override
  State<DaysAvailabilityTile> createState() => _DaysAvailabilityTileState();
}

class _DaysAvailabilityTileState extends State<DaysAvailabilityTile> {
  // final List<String> timeSlots = [
  //   '12:00 AM',
  //   '12:30 AM',
  //   '01:00 PM',
  //   '01:30 PM',
  //   '02:00 PM',
  //   '02:30 PM',
  //   '03:00 PM',
  //   '03:30 PM',
  //   '04:00 PM',
  //   '04:30 PM',
  //   '05:00 PM',
  //   '05:30 PM',
  //   '06:00 PM',
  //   '06:30 PM',
  //   '07:00 PM',
  //   '07:30 PM',
  //   '08:00 PM',
  //   '08:30 PM',
  //   '09:00 PM',
  //   '09:30 PM',
  //   '10:00 PM',
  //   '10:30 PM',
  //   '11:00 PM',
  //   '11:30 PM',
  //   '12:00 PM',
  //   '12:30 PM',
  //   '01:00 AM',
  //   '01:30 AM',
  //   '02:00 AM',
  //   '02:30 AM',
  //   '03:00 AM',
  //   '03:30 AM',
  //   '04:00 AM',
  //   '04:30 AM',
  //   '05:00 AM',
  //   '05:30 AM',
  //   '06:00 AM',
  //   '06:30 AM',
  //   '07:00 AM',
  //   '07:30 AM',
  //   '08:00 AM',
  //   '08:30 AM',
  //   '09:00 AM',
  //   '09:30 AM',
  //   '10:00 AM',
  //   '10:30 AM',
  //   '11:00 AM',
  //   '11:30 AM',
  // ];

  final List<SlotModel> selectedTimeSlots = [];

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.dayValue;
  }

  void onChanged(bool isOpened) {
    {
      if (widget.days.days[widget.dayIndex].bookingStatus == 0) {
        if (isSwitched == false) {
          setState(() {
            isSwitched = true;
            widget.days.days[widget.dayIndex].status = 1;
            // textValue = 'Switch Button is ON';
          });
        } else {
          setState(() {
            isSwitched = false;
            widget.days.days[widget.dayIndex].status = 0;
            // textValue = 'Switch Button is OFF';
          });
        }
      } else {
        BotToast.showText(text: 'Day can\'t be off due to appointment');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 10;
    final double itemWidth = size.width / 2;
    return Column(
      children: [
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.snow,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 4,
                  height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.acmeBlue,
                      borderRadius: BorderRadius.circular(16)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.symmetric(vertical: 15),
                      title: Text(
                        widget.day,
                        style: TextStyles.semiBoldTextStyle(),
                      ),
                      // trailing: IgnorePointer(
                      //   child: Transform.scale(
                      //     scale: 1.1,
                      //     child: Switch(
                      //       onChanged: onChanged,
                      //       value: isSwitched,
                      //       activeColor: AppColors.acmeBlue,
                      //       activeTrackColor: Colors.blue.shade100,
                      //       inactiveThumbColor: Colors.redAccent,
                      //       inactiveTrackColor: Colors.orange,
                      //     ),
                      //   ),
                      // ),
                      trailing: ToggleSwitch(
                        toggleCallBack: widget.toggleCallBack,
                        days: widget.days,
                        dayIndex: widget.dayIndex,
                        switchValue: widget.dayValue,
                      ),
                      children: [
                        GridView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (itemWidth / itemHeight),
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0),
                          // alignment: WrapAlignment.start,
                          // runAlignment: WrapAlignment.start,
                          // crossAxisAlignment: WrapCrossAlignment.start,
                          // runSpacing: 24,
                          // spacing: 14,
                          children:
                              List.generate(widget.timeSlots.length, (index) {
                            return TimeSlotWidget(
                              title: widget.timeSlots[index],
                              onTap: (value) {
                                setState(() {
                                  if (widget.timeSlots[index].bookingStatus ==
                                      0) {
                                    if (widget.timeSlots[index].status == 0) {
                                      widget.timeSlots[index].status = 1;
                                      selectedTimeSlots
                                          .add(widget.timeSlots[index]);
                                    } else {
                                      widget.timeSlots[index].status = 0;
                                      selectedTimeSlots
                                          .remove(widget.timeSlots[index]);
                                    }
                                    widget.callBack(selectedTimeSlots
                                        .where((element) => element.status == 1)
                                        .toList());
                                  } else {
                                    BotToast.showText(
                                        text:
                                            'Slot can\'t be off due to appointment');
                                  }
                                });
                              },
                            );
                          }),
                        ),
                      ],
                      onExpansionChanged: (isOpened) {
                        // widget.days.days[widget.dayIndex].status = 1;
                        // setState(() {
                        //   onChanged(isOpened);
                        // });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
