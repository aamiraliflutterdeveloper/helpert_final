import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/core/services/socket_service.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/video/bloc/notification_count/message_count_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../notifications/repo/notification_repo.dart';

class MessageCountBloc extends Cubit<MessageCountState> {
  MessageCountBloc() : super(InitialMessageCountState());

  static MessageCountBloc get(context) => BlocProvider.of(context);

  void emitMessageCount({int? receiverId}) {
    Socket socket = SocketService.instance.socket;

    try {
      socket.emit(SocketEmit.GET_MESSAGE_COUNT, {
        'user_id': receiverId ?? AuthRepo.instance.user.userId,
      });
    } catch (e) {
      debugPrint('');
    }
  }

  Future<void> updateMessageCountApi() async {
    var data = FormData.fromMap(
        {"user_id": AuthRepo.instance.user.userId, "type": "message"});
    try {
      bool result =
          await NotificationRepo.instance.updateNotificationCountApi(data);
      if (result) {
        emitMessageCount();
      }
    } catch (e) {
      debugPrint('');
    }
  }

  void listenToMessageCount() {
    Socket socket = SocketService.instance.socket;

    try {
      socket.on(
        '${AuthRepo.instance.user.userId}-${SocketListeners.GET_MESSAGE_COUNT}',
        (data) {
          if (data['result'] == 'success') {
            emit(MessageCountLoaded(messageCount: data['data']));
          } else {
            emit(MessageCountLoaded(messageCount: 0));
          }
        },
      );
    } catch (e) {
      emit(MessageCountLoaded(messageCount: 0));
    }
  }
}
