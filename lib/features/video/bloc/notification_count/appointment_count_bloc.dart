import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/core/services/socket_service.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/notifications/repo/notification_repo.dart';
import 'package:helpert_app/features/video/bloc/notification_count/appointment_count_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AppointmentCountBloc extends Cubit<AppointmentCountState> {
  AppointmentCountBloc() : super(InitialAppointmentCountState());

  static AppointmentCountBloc get(context) => BlocProvider.of(context);

  void emitAppointmentCount({int? receiverId}) {
    Socket socket = SocketService.instance.socket;

    try {
      socket.emit(SocketEmit.GET_APPOINTMENT_COUNT, {
        'user_id': receiverId ?? AuthRepo.instance.user.userId,
      });
    } catch (e) {
      debugPrint('');
    }
  }

  Future<void> updateNotificationCountApi() async {
    var data = FormData.fromMap(
        {"user_id": AuthRepo.instance.user.userId, "type": "appointment"});
    try {
      bool result =
          await NotificationRepo.instance.updateNotificationCountApi(data);
      if (result) {
        emitAppointmentCount();
      }
    } catch (e) {
      debugPrint('');
    }
  }

  void listenToAppointmentCount() {
    Socket socket = SocketService.instance.socket;

    try {
      socket.on(
        '${AuthRepo.instance.user.userId}-${SocketListeners.GET_APPOINTMENT_COUNT}',
        (data) {
          if (data['result'] == 'success') {
            emit(AppointmentCountLoaded(appointmentCount: data['data']));
          } else {
            emit(AppointmentCountLoaded(appointmentCount: 0));
          }
        },
      );
    } catch (e) {
      emit(AppointmentCountLoaded(appointmentCount: 0));
    }
  }
}
