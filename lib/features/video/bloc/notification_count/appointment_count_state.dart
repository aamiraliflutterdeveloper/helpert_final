abstract class AppointmentCountState {}

class InitialAppointmentCountState extends AppointmentCountState {}

class AppointmentCountLoaded extends AppointmentCountState {
  final int appointmentCount;

  AppointmentCountLoaded({
    required this.appointmentCount,
  });
}
