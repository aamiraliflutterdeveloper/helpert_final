import 'package:flutter/material.dart';

import '../../appointment/model/appointment_model.dart';

@immutable
abstract class VideoCallState {}

class VideoCallInitial extends VideoCallState {}

class VideoCallLoading extends VideoCallState {}

class VideoCallLoaded extends VideoCallState {
  final bool enableCallButton;
  final int doctorId;
  final int bookingId;
  final int userId;
  final String error;
  final AppointmentModel? appointmentModel;
  VideoCallLoaded(this.appointmentModel, this.enableCallButton, this.error,
      this.doctorId, this.userId, this.bookingId);
}

class VideoCallError extends VideoCallState {
  final String error;

  VideoCallError(this.error);
}
