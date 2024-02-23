import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/features/book_call/model/booking_model.dart';
import 'package:helpert_app/features/notifications/repo/notification_repo.dart';
import 'package:meta/meta.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../core/services/socket_service.dart';
import '../../auth/repo/auth_repo.dart';
import '../model/chat_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  // list of chat
  List<Chat> chatList = [];

  void emitChatHistory(int senderId, int receiverId) {
    Socket socket = SocketService.instance.socket;
    socket.emit(SocketEmit.CHAT_HISTORY_SUBSCRIBER, {
      'sender_id': senderId,
      'receiver_id': receiverId,
    });
  }

  void timeOverFunction() {
    int minutes = 0;
    int seconds = 0;
    DateTime dateTime = getLocalTime();
    seconds = dateTime.second;
    minutes = dateTime.minute;
    Timer.periodic(Duration(seconds: 1), (timer) {
      seconds = seconds + 1;
      if (seconds == 60) {
        seconds = 0;
        minutes = minutes + 1;
      }

      if ((minutes == 29 && seconds == 57) ||
          (dateTime.minute == 59 && dateTime.second == 57)) {
        timer.cancel();
      } else {}
    });
  }

  DateTime getLocalTime() {
    DateTime dateTime = DateTime.now();
    return dateTime;
  }

  bool getVideoCallAvailability(List<BookingModel> bookings, String otherId) {
    List<BookingModel> myBookings = bookings
        .where((element) =>
            element.doctorId == AuthRepo.instance.user.userId ||
            element.bookingUserId == AuthRepo.instance.user.userId &&
                element.doctorId == otherId ||
            element.bookingUserId == otherId)
        .toList();
    if (myBookings.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void listenAndLoadChatHistory(int senderId, int receiverId) {
    Socket socket = SocketService.instance.socket;

    emit(ChatLoading());

    socket.on(
      '$senderId-$receiverId-${SocketListeners.CHAT_HISTORY_LISTENER}',
      (data) {
        if (data['result'] == 'success') {
          chatList = List<Chat>.from(
            data["data"].map(
              (x) => Chat.fromJson(x),
            ),
          );
          if (chatList.isEmpty) {
            emit(NoChatFound());
          } else {
            emit(ChatLoaded(chatList));
          }
        } else {}
      },
    );
  }

  void emitMessage(int senderId, int receiverId, String msg) {
    Socket socket = SocketService.instance.socket;

    socket.emit(SocketEmit.SEND_MESSAGE, {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': msg,
    });
  }

  void emitAttachment(int senderId, int receiverId, File file) async {
    Socket socket = SocketService.instance.socket;

    // String fileName = file.path.split('/').last;
    //
    // MultipartFile? image = await MultipartFile.fromFile(file.path,
    //     filename: fileName,
    //     contentType: MediaType("image", fileName.split(".").last));

    // String fileName = file.path.split("/").last;

    // File? compressedImage = await FlutterImageCompress.compressAndGetFile(
    //   file.path,
    //   file.path,
    //   quality: 50,
    // );
    String base64Image = base64Encode(file.readAsBytesSync());

    socket.emit(SocketEmit.SEND_MESSAGE, {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': 'with image',
      'attachment': 'data:image/png;base64,' + base64Image,
    });
  }

  void listenToMessages() {
    Socket socket = SocketService.instance.socket;
    updateMessageCountApi();
    socket.on(
      '${AuthRepo.instance.user.userId}${SocketListeners.RECEIVE_MESSAGE_LISTENER}',
      (data) {
        log('data is :: ${data.toString()}');
        if (data['result'] == 'success') {
          Chat chat = Chat.fromJson(data['data']);
          chatList.add(chat);
          emit(ChatLoaded(chatList));
        } else {}
      },
    );
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

  @override
  Future<void> close() {
    SocketService.instance.socket.off(SocketListeners.CHAT_HISTORY_LISTENER);
    SocketService.instance.socket.off(
        '${AuthRepo.instance.user.userId}${SocketListeners.RECEIVE_MESSAGE_LISTENER}');
    SocketService.instance.socket.clearListeners();
    return super.close();
  }
}
