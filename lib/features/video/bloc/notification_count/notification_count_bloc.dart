import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/core/services/socket_service.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/video/bloc/notification_count/notification_count_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class NotificationCountBloc extends Cubit<NotificationCountState> {
  NotificationCountBloc() : super(InitialNotificationCountState());

  static NotificationCountBloc get(context) => BlocProvider.of(context);
  void emitNotificationCount({int? receiverId}) {
    Socket socket = SocketService.instance.socket;

    try {
      socket.emit(SocketEmit.GET_NOTIFICATIONS, {
        'user_id': receiverId ?? AuthRepo.instance.user.userId,
      });
    } catch (e) {
      debugPrint('');
    }
  }

  void listenToNotificationCount() {
    Socket socket = SocketService.instance.socket;

    try {
      socket.on(
        '${AuthRepo.instance.user.userId}-${SocketListeners.GET_NOTIFICATIONS}',
        (data) {
          if (data['result'] == 'success') {
            emit(NotificationCountLoaded(notificationCount: data['data']));
          } else {
            emit(NotificationCountLoaded(notificationCount: 0));
          }
        },
      );
    } catch (e) {
      emit(NotificationCountLoaded(notificationCount: 0));
    }
  }
}
