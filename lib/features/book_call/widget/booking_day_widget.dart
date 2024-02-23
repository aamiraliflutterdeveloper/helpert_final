import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

import '../../../constants/consts.dart';
import '../model/calendar_data_model.dart';

class BookingDayWidget extends StatelessWidget {
  final CalendarDaysModel calendarDaysModel;
  final double margin;
  final bool isSelected;
  const BookingDayWidget(
      {Key? key,
      required this.margin,
      required this.isSelected,
      required this.calendarDaysModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: margin),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.acmeBlue : AppColors.pureWhite,
        border: Border.all(
          color: Color(0xFF6B779A).withOpacity(.1),
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Column(
        children: [
          TextView(
            calendarDaysModel.dayShortDate,
            textStyle: TextStyles.regularTextStyle(
              fontSize: 14,
              fontFamily: proximaFamily,
              textColor: isSelected ? AppColors.pureWhite : Color(0xFF6B779A),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextView(
            calendarDaysModel.dayShortName.toUpperCase(),
            textStyle: TextStyles.regularTextStyle(
              fontSize: 14,
              fontFamily: proximaFamily,
              textColor: isSelected ? AppColors.pureWhite : Color(0xFF6B779A),
            ),
          ),
        ],
      ),
    );
  }
}
