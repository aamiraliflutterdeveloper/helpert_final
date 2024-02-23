import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/book_call/model/calendar_data_model.dart';
import 'package:intl/intl.dart';

import '../../../constants/consts.dart';
import '../../../utils/date_formatter.dart';
import '../bloc/available_slots_bloc.dart';
import '../bloc/calendar_data_bloc.dart';
import 'booking_day_widget.dart';

class BookingDaysWidget extends StatefulWidget {
  final int doctorId;

  final List<CalendarDaysModel> calendarDays;
  final Function(String, String) callback;
  const BookingDaysWidget({
    Key? key,
    required this.calendarDays,
    required this.doctorId,
    required this.callback,
  }) : super(key: key);

  @override
  State<BookingDaysWidget> createState() => _BookingDaysWidgetState();
}

class _BookingDaysWidgetState extends State<BookingDaysWidget> {
  int selectedIndex = 0;
  bool monthNameChanged = true;
  bool firstTime = true;
  String monthYear = '';
  @override
  Widget build(BuildContext context) {
    if (monthNameChanged) {
      monthNameChanged = false;
      monthYear = DateFormat('MMMM, yyyy').format(widget.calendarDays[0].date);
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              String? date =
                  await DateFormatter.pickDateDialog(context, DateTime.now());
              if (date != null) {
                DateTime time1 =
                    DateFormat('dd MM yyyy').parse(date.replaceAll('-', ' '));
                monthYear = DateFormat('MMMM, yyyy').format(time1);
                setState(() {});
                context
                    .read<CalendarDataBloc>()
                    .fetchAvailableDays(widget.doctorId, date);
                String dateToShow = DateFormat('dd MMM yyyy').format(time1);
                String selectedDate = date;
                widget.callback(dateToShow, selectedDate);
              }
            },
            child: Row(
              children: [
                Text(
                  monthYear,
                  textAlign: TextAlign.start,
                  style: TextStyles.regularTextStyle(
                    fontSize: 15,
                    fontFamily: proximaFamily,
                    textColor: Color(0xFF222B45),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 30,
                    color: Color(0xFF222B45),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                widget.calendarDays.length,
                (index) {
                  if (firstTime) {
                    DateTime date = DateTime.parse(
                        DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.parse(
                            widget.calendarDays[0].date
                                .toString()
                                .replaceFirst('Z', ''))));
                    context
                        .read<AvailableSlotsBloc>()
                        .availableSlots(widget.doctorId, date);
                    firstTime = false;
                  }
                  return GestureDetector(
                    onTap: () {
                      String dateToShow = DateFormat('dd MMM yyyy')
                          .format(widget.calendarDays[index].date);
                      String selectedDate = DateFormatter.dayMonthYear(
                          widget.calendarDays[index].date);
                      widget.callback(dateToShow, selectedDate);
                      setState(() {
                        selectedIndex = index;
                        firstTime = false;
                      });

                      DateTime date = DateTime.parse(
                          DateFormat("yyyy-MM-dd hh:mm:ss").format(
                              DateTime.parse(widget.calendarDays[index].date
                                  .toString()
                                  .replaceFirst('Z', ''))));
                      context
                          .read<AvailableSlotsBloc>()
                          .availableSlots(widget.doctorId, date);
                    },
                    child: BookingDayWidget(
                      calendarDaysModel: widget.calendarDays[index],
                      margin: index == 6 ? 0 : 10,
                      isSelected: selectedIndex == index,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
