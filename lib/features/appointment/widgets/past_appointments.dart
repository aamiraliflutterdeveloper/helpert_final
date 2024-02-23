import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/appointment/model/appointment_model.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../screens/appointment_detail_screen.dart';
import 'appointment_widget.dart';

class PastAppointments extends StatelessWidget {
  final List<AppointmentModel> pastAppointments;
  const PastAppointments({Key? key, required this.pastAppointments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pastAppointments.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 20, bottom: 120),
            itemCount: pastAppointments.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
               // if (pastAppointments[index].status == 3) {
                  NavRouter.push(
                      context,
                      AppointmentDetailScreen(
                        appointmentModel: pastAppointments[index],
                      ));
               // }
              },
              child: AppointmentWidget(
                forwardArrowCallback: () {
                  if (pastAppointments[index].status == 3) {
                    NavRouter.push(
                        context,
                        AppointmentDetailScreen(
                          appointmentModel: pastAppointments[index],
                        ));
                  }
                },
                image: pastAppointments[index].userImage,
                name: pastAppointments[index].userName,
                callStatus: pastAppointments[index].status == 2
                    ? 'Declined'
                    : pastAppointments[index].status == 3
                        ? 'Completed'
                        : '',
                callSTime: pastAppointments[index].startTime,
                callETime: pastAppointments[index].endTime,
              ),
            ),
          )
        : // Center(
        Center(
            child: Text(
              'You don’t have any\n Appointments.',
              textAlign: TextAlign.center,
              style: TextStyles.regularTextStyle(
                  fontSize: 14, textColor: AppColors.nickel),
            ),
          );
  }
}
