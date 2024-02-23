import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/profile/models/unAvailAbleDateModel.dart';
import 'package:helpert_app/utils/date_formatter.dart';
import 'package:intl/intl.dart';

class UnAvailableWidget extends StatelessWidget {
  final UnavailableDateModel unavailableDateModel;
  final VoidCallback deleteCallBack;
  const UnAvailableWidget(
      {Key? key,
      required this.unavailableDateModel,
      required this.deleteCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.snow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select date',
                    style: TextStyles.regularTextStyle(
                        fontSize: 10, textColor: AppColors.moon),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${DateFormatter.dayDateMonth(DateFormat("dd-MM-yyyy").parse(unavailableDateModel.startDate))} - ${DateFormatter.dayDateMonth(DateFormat("dd-MM-yyyy").parse(unavailableDateModel.endDate))}',
                    style: TextStyles.regularTextStyle(
                        fontSize: 14, textColor: AppColors.black),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: AppColors.failure,
            onPressed: deleteCallBack,
          )
        ],
      ),
    );
  }
}
