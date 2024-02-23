import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../core/services/socket_service.dart';
import '../model/recent_chat_model.dart';

part 'recent_chat_state.dart';

class RecentChatCubit extends Cubit<RecentChatState> {
  RecentChatCubit() : super(RecentChatInitial());

  void emitRecentChats() {
    int id = AuthRepo.instance.user.userId;

    Socket socket = SocketService.instance.socket;

    socket.emit(SocketEmit.RECENT_CHAT_SUBSCRIBER, {'user_id': id});
  }

  void listenRecentChats() {
    Socket socket = SocketService.instance.socket;

    try {
      socket.on(
        '${AuthRepo.instance.user.userId}-${SocketListeners.RECENT_CHAT_LISTENER}',
        (data) {
          if (data['result'] == 'success') {
            List<RecentChatModel> recentChatList = List<RecentChatModel>.from(
              data["data"].map(
                (x) => RecentChatModel.fromJson(x),
              ),
            );
            if (recentChatList.isEmpty) {
              emit(NoRecentChatFound());
            } else {
              // recentChatList.sort((a,b) => b.createdAt.compareTo(a.timestamp));
              emit(RecentChatLoaded(recentChatList));
            }
          } else {}
        },
      );
    } catch (e) {
      debugPrint('exception is :: $e');
    }
  }

  @override
  Future<void> close() {
    SocketService.instance.socket.off(
        '${AuthRepo.instance.user.userId}-${SocketListeners.RECENT_CHAT_LISTENER}');
    SocketService.instance.socket.clearListeners();
    return super.close();
  }

  void unsubscribeSocket() {
    SocketService.instance.socket.off(
        '${AuthRepo.instance.user.userId}-${SocketListeners.RECENT_CHAT_LISTENER}');
  }
}
