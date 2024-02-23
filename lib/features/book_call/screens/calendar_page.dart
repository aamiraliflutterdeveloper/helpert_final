import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/book_call/bloc/calendar_data_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/calendar_data_state.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'choose_time_screen.dart';

class CalendarPage extends StatefulWidget {
  final int userId;

  const CalendarPage({Key? key, required this.userId}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    DateTime.now();
    context.read<CalendarDataBloc>().fetchCalendarData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Book a Call',
      ),
      body: BlocConsumer<CalendarDataBloc, CalendarDataState>(
          listener: (context, state) {
        if (state is CalendarDataError) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.error);
        }
      }, builder: (context, state) {
        return state is CalendarDataLoaded
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ZoomIn(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TableCalendar(
                        headerStyle: HeaderStyle(
                          rightChevronIcon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.acmeBlue,
                          ),
                          leftChevronIcon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.acmeBlue,
                          ),
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          formatButtonTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: selectedDay,
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyles.semiBoldTextStyle(
                                fontSize: 12, textColor: AppColors.moon)),
                        weekendDays: state.calendarDataModel.unavailableDayId,
                        //Day Changed on select
                        onDaySelected: (DateTime selectDay, DateTime focusDay) {
                          bool result = dateComparision(
                              state.calendarDataModel.unavailableDate,
                              DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss")
                                  .format(DateTime.parse(selectDay
                                      .toString()
                                      .replaceFirst('Z', '')))));
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusDay;
                          });
                          if (state.calendarDataModel.unavailableDate
                                  .isNotEmpty ||
                              state.calendarDataModel.unavailableDayId
                                  .isNotEmpty) {
                            if (result ||
                                state.calendarDataModel.unavailableDayId
                                    .contains(selectDay.weekday)) {
                              BotToast.showText(
                                  text: 'This date is not available');
                            } else {
                              NavRouter.push(
                                  context,
                                  ChooseTimeScreen(
                                    doctorId: widget.userId,
                                    dayName:
                                        DateFormat('EEEE').format(selectDay),
                                    date: selectedDay,
                                  ));
                            }
                          } else {
                            NavRouter.push(
                                context,
                                ChooseTimeScreen(
                                  doctorId: widget.userId,
                                  dayName: DateFormat('EEEE').format(selectDay),
                                  date: selectedDay,
                                ));
                          }
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        },
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          defaultTextStyle: TextStyles.semiBoldTextStyle(
                              fontSize: 16, textColor: AppColors.black),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          todayDecoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.silver)),
                          todayTextStyle: TextStyles.semiBoldTextStyle(
                              fontSize: 16, textColor: AppColors.acmeBlue),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          outsideTextStyle: TextStyles.semiBoldTextStyle(
                              fontSize: 12, textColor: AppColors.silver),
                          weekendTextStyle: TextStyles.semiBoldTextStyle(
                              fontSize: 16, textColor: AppColors.failure),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.failure.withOpacity(.1),
                          ),
                        ),

                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            for (DateTime d
                                in state.calendarDataModel.userAppointment) {
                              if (day.day == d.day &&
                                  day.month == d.month &&
                                  day.year == d.year) {
                                return Container(
                                  width: 42,
                                  height: 42,
                                  decoration: const BoxDecoration(
                                      color: AppColors.acmeBlue,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyles.semiBoldTextStyle(
                                          fontSize: 16,
                                          textColor: AppColors.pureWhite),
                                    ),
                                  ),
                                );
                              }
                            }
                            for (DateTime d
                                in state.calendarDataModel.unavailableDate) {
                              if (day.day == d.day &&
                                  day.month == d.month &&
                                  day.year == d.year) {
                                return Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: AppColors.failure.withOpacity(.1),
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyles.semiBoldTextStyle(
                                          fontSize: 16,
                                          textColor: AppColors.failure),
                                    ),
                                  ),
                                );
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            DateTypeWidget(
                              title: 'Appointment',
                              color: AppColors.acmeBlue,
                              borderColor: AppColors.acmeBlue,
                            ),
                            DateTypeWidget(
                              title: 'Not Available/Booked',
                              color: AppColors.failure,
                              borderColor: AppColors.failure,
                            ),
                            DateTypeWidget(
                              title: 'Today',
                              color: AppColors.pureWhite,
                              borderColor: AppColors.silver,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : state is CalendarDataLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text('No Data Found'),
                  );
      }),
    );
  }

  bool areSameDay(DateTime one, DateTime two) {
    return one.day == two.day && one.month == two.month && one.year == two.year;
  }

  bool dateComparision(List<DateTime> dates, DateTime targetDate) {
    try {
      dates.firstWhere((date) => areSameDay(date, targetDate));
      return true;
    } catch (_) {
      return false;
    }
  }
}

class DateTypeWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Color borderColor;
  const DateTypeWidget(
      {Key? key,
      required this.title,
      required this.color,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: borderColor, width: 3)),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: TextStyles.mediumTextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
