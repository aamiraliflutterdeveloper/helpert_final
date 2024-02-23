import 'package:helpert_app/features/appointment/model/appointment_model.dart';

abstract class AppointmentsState {}

class InitialAppointmentsState extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> appointments;

  AppointmentsLoaded({required this.appointments});
}

class AppointmentsError extends AppointmentsState {
  final String error;

  AppointmentsError(this.error);
}
