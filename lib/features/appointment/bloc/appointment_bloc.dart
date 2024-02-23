import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/core/services/socket_service.dart';
import 'package:helpert_app/features/appointment/bloc/appointment_state.dart';
import 'package:helpert_app/features/appointment/model/appointment_model.dart';
import 'package:helpert_app/features/appointment/repo/appointment_repo.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../auth/repo/auth_repo.dart';

class AppointmentsBloc extends Cubit<AppointmentsState> {
  AppointmentsBloc() : super(InitialAppointmentsState());
  static AppointmentsBloc get(context) => BlocProvider.of(context);
  Future<void> appointments() async {
    try {
      emit(AppointmentsLoading());
      List<AppointmentModel> appointments =
          await AppointmentRepo.instance.appointments();
      appointments = appointments.reversed.toList();

      emit(AppointmentsLoaded(appointments: appointments));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  Future<void> approveBooking(int bookingId, int userId, int receiverId) async {
    emit(AppointmentsLoading());

    var data = FormData.fromMap({"booking_id": bookingId});
    List<AppointmentModel> appointments = [];
    var currentState = state;
    if (currentState is AppointmentsLoaded) {
      currentState.appointments
          .removeWhere((element) => element.bookingId == bookingId);
      appointments = currentState.appointments;
    }
    try {
      bool result = await AppointmentRepo.instance.approveBookingApi(data);
      if (result) {
        emit(AppointmentsError('Approved'));
        emit(AppointmentsLoaded(appointments: appointments));
        emitNotification(receiverId);
      }
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  Future<void> declineBooking(int bookingId, int userId, int receiverId) async {
    emit(AppointmentsLoading());

    var data = FormData.fromMap({"booking_id": bookingId});
    List<AppointmentModel> appointments = [];
    var currentState = state;
    if (currentState is AppointmentsLoaded) {
      currentState.appointments
          .removeWhere((element) => element.bookingId == bookingId);
      appointments = currentState.appointments;
    }
    try {
      bool result = await AppointmentRepo.instance.declineBookingApi(data);
      if (result) {
        emit(AppointmentsError('Declined'));

        emit(AppointmentsLoaded(appointments: appointments));
        emitNotification(receiverId);
      }
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  void emitNotification(int userId) {
    Socket socket = SocketService.instance.socket;

    try {
      socket.emit(SocketEmit.GET_NOTIFICATIONS, {
        'user_id': userId,
        'doctor_id': AuthRepo.instance.user.userId,
      });
    } catch (e) {
      debugPrint('emit notification exception :: $e');
    }
  }
}
