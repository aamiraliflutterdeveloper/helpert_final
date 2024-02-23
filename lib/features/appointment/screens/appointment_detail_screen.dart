import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/appointment/bloc/appointment_bloc.dart';
import 'package:helpert_app/features/appointment/bloc/appointment_state.dart';
import 'package:helpert_app/features/appointment/model/appointment_model.dart';
import 'package:helpert_app/features/notifications/bloc/notification_bloc.dart';
import 'package:helpert_app/utils/date_formatter.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:helpert_app/utils/scroll_behavior.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../book_call/widget/booking_user_detail_widget.dart';
import '../../chat/screens/chat_screen.dart';
import '../../video/bloc/notification_count/appointment_count_bloc.dart';
import '../../video/bloc/notification_count/notification_count_bloc.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final int? notificationId;
  final int? read;
  final int? userId;
  final int? receiverId;
  final AppointmentModel appointmentModel;

  const AppointmentDetailScreen({
    Key? key,
    required this.appointmentModel,
    this.userId,
    this.receiverId,
    this.notificationId,
    this.read,
  }) : super(key: key);

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  String timeZone = '';

  @override
  void initState() {
    timeZoneSetup();
    if (widget.read == 0 && widget.notificationId != null) {
      Future.wait([
        context
            .read<NotificationBloc>()
            .readNotification(widget.notificationId!),
        context.read<NotificationBloc>().updateNotificationCountApi(),
      ]);
    }
    super.initState();
  }

  Future<void> timeZoneSetup() async {
    tz.initializeTimeZones();
    var localTimeZone = tz.getLocation(widget.appointmentModel.timezone);
    var now = tz.TZDateTime.now(localTimeZone);

    const start = " ";
    const end = ".";

    final startIndex = now.toString().indexOf(start);
    final endIndex = now.toString().indexOf(end, startIndex + start.length);
    String completeTime =
        now.toString().substring(startIndex + start.length, endIndex);
    timeZone = widget.appointmentModel.timezone.replaceAll('/', ', ') +
        ' Time(${completeTime.substring(0, completeTime.length - 3)})';
    debugPrint('Time zone current time $now');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        hasElevation: true,
        title: 'Appointment',
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.silver.withOpacity(.3),
              spreadRadius: 36,
              blurRadius: 15,
              offset: const Offset(6, 0), // changes position of shadow
            ),
          ],
        ),
        child: widget.appointmentModel.status == 0
            ? BlocConsumer<AppointmentsBloc, AppointmentsState>(
                listener: (context, state) {
                if (state is AppointmentsLoading) {
                  BotToast.showLoading();
                } else if (state is AppointmentsError) {
                  BotToast.closeAllLoading();
                  BotToast.showText(text: state.error);
                }
                if (state is AppointmentsLoaded) {
                  BotToast.closeAllLoading();
                  NavRouter.pop(context, true);
                }
              }, builder: (context, state) {
                return Container(
                  height: 50,
                  color: AppColors.pureWhite,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: CustomElevatedButton(
                              color: AppColors.failure,
                              padding: EdgeInsets.all(0),
                              onTap: () {
                                context
                                    .read<AppointmentsBloc>()
                                    .declineBooking(
                                        widget.appointmentModel.bookingId,
                                        widget.appointmentModel.userId,
                                        widget.receiverId!)
                                    .then((value) {
                                  AppointmentCountBloc.get(context)
                                      .emitAppointmentCount(
                                          receiverId: widget.receiverId);
                                });
                              },
                              title: 'Decline'),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: CustomElevatedButton(
                              padding: EdgeInsets.all(0),
                              onTap: () {
                                context
                                    .read<AppointmentsBloc>()
                                    .approveBooking(
                                        widget.appointmentModel.bookingId,
                                        widget.appointmentModel.userId,
                                        widget.receiverId!)
                                    .then((value) {
                                  AppointmentCountBloc.get(context)
                                      .emitAppointmentCount(
                                          receiverId: widget.receiverId);
                                  NotificationCountBloc.get(context)
                                      .emitNotificationCount(
                                          receiverId: widget.receiverId);
                                });
                              },
                              title: 'Approve'),
                        ),
                      ),
                    ],
                  ),
                );
              })
            : widget.appointmentModel.status == 1 ||
                    widget.appointmentModel.status == 3
                ? SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                        onTap: () {
                          NavRouter.push(
                            context,
                            ChatScreen(
                              name:
                                  '${widget.appointmentModel.firstName} ${widget.appointmentModel.lastName}',
                              image: widget.appointmentModel.userImage,
                              receiverId: widget.userId ??
                                  widget.appointmentModel.userId,
                              speciality:
                                  widget.appointmentModel.specialization ?? '',
                              timezone: widget.appointmentModel.timezone,
                              sessionRate: widget.appointmentModel.sessionRate,
                            ),
                          );
                          // NavRouter.push(context, MessageScreen());
                        },
                        title:
                            'Message Now(Start at ${widget.appointmentModel.startTime})'),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                        disable: true,
                        onTap: () {
                          // NavRouter.push(
                          //     context,
                          //     CalendarPage(
                          //       userId: 1,
                          //     ));
                        },
                        title: widget.appointmentModel.status == 2
                            ? 'Cancelled'
                            : 'Completed'),
                  ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: BookingUserDetailWidget(
                    topGap: 0,
                    doctorId: widget.appointmentModel.userId,
                    name:
                        '${widget.appointmentModel.firstName} ${widget.appointmentModel.lastName}',
                    image: widget.appointmentModel.userImage ?? '',
                    specialization:
                        widget.appointmentModel.specialization ?? '',
                    sessionRate: 0,
                    timeZone: timeZone,
                  ),
                ),
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Appointment Time",
                    style: TextStyles.boldTextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    DateFormatter.fulDayDateMonthYear(
                        widget.appointmentModel.date),
                    style: TextStyles.regularTextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 4),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    widget.appointmentModel.status == 0
                        ? "Pending"
                        : widget.appointmentModel.status == 1
                            ? "Scheduled"
                            : widget.appointmentModel.status == 2
                                ? "Decline"
                                : widget.appointmentModel.status == 3
                                    ? "Completed"
                                    : "Cancelled",
                    style: TextStyles.regularTextStyle(
                      textColor: widget.appointmentModel.status == 0
                          ? AppColors.silver
                          : widget.appointmentModel.status == 1
                              ? AppColors.acmeBlue
                              : widget.appointmentModel.status == 2
                                  ? AppColors.failure
                                  : widget.appointmentModel.status == 3
                                      ? AppColors.success
                                      : AppColors.warning,
                    )),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    "${widget.appointmentModel.startTime} - ${widget.appointmentModel.endTime}",
                    style: TextStyles.regularTextStyle()),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.snow),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Discussion Topic or Problems to be discussed.",
                        style: TextStyles.regularTextStyle(
                            fontSize: 12, textColor: AppColors.nickel)),
                    const SizedBox(height: 5),
                    Text(
                      widget.appointmentModel.appointmentDescription,
                      style: TextStyles.regularTextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Text("Fee Information",
                    style: TextStyles.boldTextStyle(fontSize: 16)),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
                child: Text("Paid",
                    style: TextStyles.regularTextStyle(
                        fontSize: 16, textColor: AppColors.acmeBlue)),
              ),
              //const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
