import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/constants/consts.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/book_call/bloc/calendar_data_state.dart';
import 'package:helpert_app/features/book_call/screens/offering_screen.dart';
import 'package:helpert_app/features/book_call/widget/booking_user_detail_widget.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';
import 'package:helpert_app/utils/date_formatter.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../common_widgets/bottons/custom_elevated_button.dart';
import '../../../common_widgets/fetch_svg.dart';
import '../../../common_widgets/textfield/custom_textformfield.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/asset_paths.dart';
import '../../../utils/nav_router.dart';
import '../bloc/calendar_data_bloc.dart';
import '../widget/booking_available_slots_widget.dart';
import '../widget/booking_days_widget.dart';

class BookingSlotScreen extends StatefulWidget {
  final int doctorId;
  final String doctorName;
  final String doctorImage;
  final String specialization;
  final int sessionRate;
  final String timeZone;
  const BookingSlotScreen(
      {Key? key,
      required this.doctorId,
      required this.doctorName,
      required this.doctorImage,
      required this.specialization,
      required this.sessionRate,
      required this.timeZone})
      : super(key: key);

  @override
  State<BookingSlotScreen> createState() => _BookingSlotScreenState();
}

class _BookingSlotScreenState extends State<BookingSlotScreen> {
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String dateToShow = '';
  String selectedDate = '';
  bool firstTime = true;
  SlotModel? selectedSlot;
  DaysModel? selectedDay;
  DateTime? dateTime;
  String timeZone = '';
  @override
  void initState() {
    timeZoneSetup();
    dateTime = DateTime.now();
    var date = DateFormatter.dayMonthYear(dateTime!);
    context.read<CalendarDataBloc>().fetchAvailableDays(widget.doctorId, date);

    super.initState();
  }

  Future<void> timeZoneSetup() async {
    tz.initializeTimeZones();
    var localTimeZone = tz.getLocation(widget.timeZone);
    var now = tz.TZDateTime.now(localTimeZone);

    const start = " ";
    const end = ".";

    final startIndex = now.toString().indexOf(start);
    final endIndex = now.toString().indexOf(end, startIndex + start.length);
    String completeTime =
        now.toString().substring(startIndex + start.length, endIndex);
    timeZone = widget.timeZone.replaceAll('/', ', ') +
        ' Time(${completeTime.substring(0, completeTime.length - 3)})';
    debugPrint('Time zone current time $now');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarDataBloc, CalendarDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CalendarDaysLoaded && firstTime) {
            if (state.calendarDaysList.isNotEmpty) {
              firstTime = false;
              dateToShow = DateFormat('dd MMM yyyy')
                  .format(state.calendarDaysList[0].date);
              selectedDate =
                  DateFormatter.dayMonthYear(state.calendarDaysList[0].date);
            }
          }
          return Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: AppColors.silver,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    width: double.infinity,
                    child: CustomElevatedButton(
                      disable: state is! CalendarDaysLoaded,
                      onTap: () {
                        if (selectedSlot != null && selectedDay != null) {
                          if (_formKey.currentState!.validate()) {
                            NavRouter.push(
                                context,
                                OfferingScreen(
                                    appointmentDescription:
                                        descriptionController.text,
                                    dayId: selectedDay!.dayId,
                                    slotId: selectedSlot!.slotId,
                                    date: selectedDate,
                                    doctorId: widget.doctorId,
                                    sessionRate: widget.sessionRate,
                                    doctorImage: widget.doctorImage));
                          }
                        } else {
                          BotToast.showText(text: 'Please add complete detail');
                        }
                      },
                      title: 'Book Appointment',
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 40),
                    child: state is CalendarDaysLoaded
                        ? state.calendarDaysList.isNotEmpty
                            ? SingleChildScrollView(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: BookingUserDetailWidget(
                                        doctorId: widget.doctorId,
                                        name: widget.doctorName,
                                        image: widget.doctorImage,
                                        specialization: widget.specialization,
                                        sessionRate: widget.sessionRate,
                                        timeZone: timeZone,
                                      ),
                                    ),
                                    BookingDaysWidget(
                                      callback: (v1, v2) => {
                                        setState(() {
                                          dateToShow = v1;
                                          selectedDate = v2;
                                        })
                                      },
                                      doctorId: widget.doctorId,
                                      calendarDays: state.calendarDaysList,
                                    ),
                                    BookingAvailableSlotsWidget(
                                      callback: (slot, day) {
                                        selectedSlot = slot;
                                        selectedDay = day;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Form(
                                        key: _formKey,
                                        child: CustomTextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            isMaxLines: 6,
                                            keyboardType:
                                                TextInputType.multiline,
                                            controller: descriptionController,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Question / Problem';
                                              }
                                              return null;
                                            },
                                            labelText:
                                                'Write your Questions / Problems.',
                                            onChanged: (val) {}),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: TextView(
                                        'Selected date, $dateToShow',
                                        textStyle: TextStyles.regularTextStyle(
                                          fontSize: 15,
                                          fontFamily: proximaFamily,
                                          textColor: Color(0xFF666666),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(child: Text('Nothing to show'))
                        : state is CalendarDataLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: Text('Nothing to show'),
                              )),

                /// Back button
                Positioned(
                  top: 40,
                  left: 8,
                  child: IconButton(
                    splashRadius: 24,
                    onPressed: () {
                      NavRouter.pop(context);
                    },
                    icon: const SvgImage(
                      path: ic_backbutton,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
