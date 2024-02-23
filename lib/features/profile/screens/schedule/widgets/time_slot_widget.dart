import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/consts.dart';

class TimeSlotWidget extends StatelessWidget {
  final SlotModel title;
  final Function(SlotModel) onTap;
  const TimeSlotWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title.bookingStatus == 0
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(title),
            child: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: title.status == 1
                      ? AppColors.acmeBlue
                      : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: title.status == 1
                        ? AppColors.acmeBlue
                        : Color(0xFF6B779A).withOpacity(.1),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 6, 10, 6),
                child: Text(title.slotTime,
                    style: TextStyle(
                        color: title.status == 1
                            ? AppColors.pureWhite
                            : AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: poppinsFamily)),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              BotToast.showText(text: 'Slot already booked');
            },
            child: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.silver,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: title.status == 1
                        ? AppColors.acmeBlue
                        : Color(0xFF6B779A).withOpacity(.1),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 6, 10, 6),
                child: Text(title.slotTime,
                    style: TextStyle(
                        color: title.status == 1
                            ? AppColors.pureWhite
                            : AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: poppinsFamily)),
              ),
            ),
          );
  }
}
