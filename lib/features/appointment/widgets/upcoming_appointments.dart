import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/appointment/model/appointment_model.dart';
import 'package:helpert_app/features/appointment/screens/appointment_detail_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';

import 'appointment_widget.dart';

class UpcomingAppointments extends StatelessWidget {
  final List<AppointmentModel> upcomingAppointments;
  const UpcomingAppointments({Key? key, required this.upcomingAppointments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return upcomingAppointments.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 20, bottom: 120),
            itemCount: upcomingAppointments.length,
            itemBuilder: (context, index) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                NavRouter.push(
                    context,
                    AppointmentDetailScreen(
                      appointmentModel: upcomingAppointments[index],
                    ));
              },
              child: AppointmentWidget(
                forwardArrowCallback: () {
                  NavRouter.push(
                      context,
                      AppointmentDetailScreen(
                        appointmentModel: upcomingAppointments[index],
                      ));
                },
                image: upcomingAppointments[index].userImage,
                name: upcomingAppointments[index].userName,
                callStatus: 'Scheduled',
                callSTime: upcomingAppointments[index].startTime,
                callETime: upcomingAppointments[index].endTime,
              ),
            ),
          )
        : // Center(
        Center(
            child: Text(
              'You don’t have any\n Appointments today.',
              textAlign: TextAlign.center,
              style: TextStyles.regularTextStyle(
                  fontSize: 14, textColor: AppColors.nickel),
            ),
          );
  }
}
