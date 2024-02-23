import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants/api_endpoints.dart';

class SocketService {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  SocketService._privateConstructor();

  static final SocketService instance = SocketService._privateConstructor();

  Future<void> init() async {
    _socket = IO.io(SOCKET_URL, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    _socket.connect();
    _socket.onConnect((_) => debugPrint('SOCKET CONNECTED'));
  }
}

abstract class SocketEmit {
  static const String RECENT_CHAT_SUBSCRIBER = 'alpha';
  static const String CHAT_HISTORY_SUBSCRIBER = 'beta';
  static const String SEND_MESSAGE = 'beta';
  static const String START_CALL = 'beta';
  static const String STATUS_CALL = 'beta';
  static const String GET_NOTIFICATIONS = 'beta';
  static const String GET_MESSAGE_COUNT = 'beta';
  static const String GET_APPOINTMENT_COUNT = 'beta';
}

abstract class SocketListeners {
  static const String RECENT_CHAT_LISTENER = 'beta';
  static const String CHAT_HISTORY_LISTENER = 'beta';
  static const String RECEIVE_MESSAGE_LISTENER = 'beta';
  static const String START_CALL = 'beta';
  static const String STATUS_CALL = 'beta';
  static const String GET_NOTIFICATIONS = 'beta';
  static const String GET_MESSAGE_COUNT = 'beta';
  static const String GET_APPOINTMENT_COUNT = 'beta';
}
