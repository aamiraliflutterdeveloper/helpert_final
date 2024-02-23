import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/common_widgets/components/custom_tabbar.dart';
import 'package:helpert_app/features/appointment/bloc/appointment_bloc.dart';
import 'package:helpert_app/features/appointment/bloc/appointment_state.dart';
import 'package:helpert_app/features/appointment/widgets/past_appointments.dart';
import 'package:helpert_app/features/appointment/widgets/upcoming_appointments.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    context.read<AppointmentsBloc>().appointments();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Appointments',
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            CustomTabBar(
              controller: _controller,
              tabs: const ['Upcoming', 'Past'],
              onTap: (index) {},
            ),
            BlocConsumer<AppointmentsBloc, AppointmentsState>(
                listener: (context, state) {
              if (state is AppointmentsLoading) {
                BotToast.showLoading();
              } else if (state is AppointmentsError) {
                BotToast.closeAllLoading();
                BotToast.showText(text: state.error);
              }
              if (state is AppointmentsLoaded) {
                BotToast.closeAllLoading();
              }
            }, builder: (context, state) {
              return state is AppointmentsLoaded
                  ? Expanded(
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: _controller,
                        children: [
                          UpcomingAppointments(
                            upcomingAppointments: state.appointments
                                .where((element) => element.status == 1)
                                .toList(),
                          ),
                          PastAppointments(
                            pastAppointments: state.appointments
                                .where((element) =>
                                    element.status == 2 || element.status == 3)
                                .toList(),
                          ),
                        ],
                      ),
                    )
                  : state is AppointmentsLoading
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text('No appointment found'),
                          ),
                        );
            }),
          ],
        ),
      ),
    );
  }
}
