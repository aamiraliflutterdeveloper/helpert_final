import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/notifications/bloc/notification_state.dart';
import 'package:helpert_app/features/notifications/model/notification_model.dart';
import 'package:helpert_app/features/notifications/repo/notification_repo.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../core/services/socket_service.dart';

class NotificationBloc extends Cubit<NotificationState> {
  NotificationBloc() : super(InitialNotificationState());
  Future<void> fetchNotification({bool loading = true}) async {
    if (loading) emit(NotificationLoading());
    try {
      List<NotificationModel> notifications =
          await NotificationRepo.instance.fetchNotificationsApi();

      emit(NotificationLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> readNotification(int notificationId) async {
    var data = FormData.fromMap({"notification_id": notificationId});

    try {
      List<NotificationModel> notifications = [];
      var currentState = state;
      if (currentState is NotificationLoaded) {
        currentState.notifications
            .where((element) => element.notificationId == notificationId)
            .first
            .read = 1;
        notifications = currentState.notifications;
      }
      bool result = await NotificationRepo.instance.readNotificationApi(data);
      if (result) emit(NotificationLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  void emitNotificationCount() {
    Socket socket = SocketService.instance.socket;

    try {
      socket.emit(SocketEmit.GET_NOTIFICATIONS, {
        'user_id': AuthRepo.instance.user.userId,
      });
    } catch (e) {
      debugPrint('');
    }
  }

  Future<void> updateNotificationCountApi() async {
    var data = FormData.fromMap(
        {"user_id": AuthRepo.instance.user.userId, "type": "notification"});
    try {
      bool result =
          await NotificationRepo.instance.updateNotificationCountApi(data);
      if (result) {
        emitNotificationCount();
      }
    } catch (e) {
      debugPrint('');
    }
  }
}
