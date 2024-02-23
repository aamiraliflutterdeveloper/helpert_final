import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:helpert_app/core/services/socket_service.dart';
import 'package:quiver/async.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../constants/consts.dart';
import '../../../auth/repo/auth_repo.dart';
import '../../model/call_model.dart';
import '../../repo/home_repo.dart';
import '../home/home_cubit.dart';
import 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());

  static CallCubit get(context) => BlocProvider.of(context);

  //Agora video room

  int? remoteUid;
  RtcEngine? engine;

  void timeOverFunction() {
    int minutes = 0;
    int seconds = 0;
    DateTime dateTime = getLocalTime();
    seconds = dateTime.second;
    minutes = dateTime.minute;
    Timer.periodic(Duration(seconds: 1), (timer) {
      timer.cancel();
      seconds = seconds + 1;
      if (seconds == 60) {
        seconds = 0;
        minutes = minutes + 1;
      }

      // if ((dateTime.minute == 32 && dateTime.second == 50) ||
      //     (dateTime.minute == 59 && dateTime.second == 50)) {
      //   timer.cancel();
      // } else {
      // }
    });
  }

  DateTime getLocalTime() {
    DateTime dateTime = DateTime.now();
    return dateTime;
  }

  Future<void> initAgoraAndJoinChannel(
      {required String channelToken,
      required String channelName,
      required bool isCaller,
      required int uId,
      required BuildContext context,
      required CallModel callModel}) async {
    //create the engine
    engine = await RtcEngine.create(agoraAppId);
    await engine!.enableVideo();
    engine!.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {},
        userJoined: (int uid, int elapsed) {
          remoteUid = uid;
          startCallTimer();
          emit(AgoraRemoteUserJoinedEvent());
        },
        userOffline: (int uid, UserOfflineReason reason) {
          if (callModel.receiverId == uid || callModel.callerId == uid) {
            emitStatusCall(
                context: context,
                current: 0,
                status: CallStatus.end,
                callModel: callModel);
            remoteUid = null;
            emit(AgoraUserLeftEvent());
          }
        },
      ),
    );

    //join channel
    await engine!
        .joinChannel(callModel.token, callModel.channelName!, null, uId);
    if (isCaller) {
      emit(AgoraInitForSenderSuccessState());
      playContactingRing(isCaller: true);
    } else {
      emit(AgoraInitForReceiverSuccessState());
    }
  }

  //Sender
  //Sender

  Future<void> playContactingRing({required bool isCaller}) async {
    String audioAsset = "assets/sounds/ringlong.mp3";

    FlutterRingtonePlayer.play(
      fromAsset: audioAsset,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
    if (isCaller) {
      startCountdownCallTimer();
    }
  }

  int current = 0;
  late CountdownTimer countDownTimer;
  void startCountdownCallTimer() {
    countDownTimer = CountdownTimer(
      const Duration(seconds: callDurationInSec),
      const Duration(seconds: 1),
    );
    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      current = callDurationInSec - duration.elapsed.inSeconds;
    });

    sub.onDone(() {
      sub.cancel();
      emit(DownCountCallTimerFinishState());
    });
  }

  int callCurrent = 0;
  late CountdownTimer callCountTimer;
  void startCallTimer() {
    callCountTimer = CountdownTimer(
      const Duration(seconds: 1800),
      const Duration(seconds: 1),
    );
    var sub = callCountTimer.listen(null);
    sub.onData((duration) {
      callCurrent = 1800 - duration.elapsed.inSeconds;
    });

    sub.onDone(() {
      sub.cancel();
      emit(DownCountCallTimerFinishState());
    });
  }

  bool muted = false;
  Widget muteIcon = const Icon(
    Icons.keyboard_voice_rounded,
    color: Colors.black,
  );

  Future<void> toggleMuted() async {
    muted = !muted;
    muteIcon = muted
        ? const Icon(
            Icons.mic_off_rounded,
            color: Colors.black,
          )
        : const Icon(
            Icons.keyboard_voice_rounded,
            color: Colors.black,
          );
    await engine!.muteLocalAudioStream(muted);
    emit(AgoraToggleMutedState());
  }

  Future<void> switchCamera() async {
    await engine!.switchCamera();
    emit(AgoraSwitchCameraState());
  }

  void listenToStatusCall(BuildContext context) {
    Socket socket = SocketService.instance.socket;
    var _homeCubit = HomeCubit.get(context);

    try {
      socket.on(
          '${AuthRepo.instance.user.userId.toString()}-${SocketListeners.STATUS_CALL}',
          (data) {
        if (data['result'] == 'success') {
          CallModel incomingCall = CallModel.fromJson(data['data']);

          String? status = incomingCall.status;
          if (status == CallStatus.accept.name) {
            _homeCubit.currentCallStatus = CallStatus.accept;
            emit(CallAcceptState());
          }
          if (status == CallStatus.reject.name) {
            _homeCubit.currentCallStatus = CallStatus.reject;
            SocketService.instance.socket.off(
                '${AuthRepo.instance.user.userId}-${SocketListeners.STATUS_CALL}');
            emit(CallRejectState());
          }
          if (status == CallStatus.unAnswer.name) {
            _homeCubit.currentCallStatus = CallStatus.unAnswer;
            SocketService.instance.socket.off(
                '${AuthRepo.instance.user.userId}-${SocketListeners.STATUS_CALL}');
            emit(CallNoAnswerState());
          }
          if (status == CallStatus.cancel.name) {
            _homeCubit.currentCallStatus = CallStatus.cancel;
            SocketService.instance.socket.off(
                '${AuthRepo.instance.user.userId}-${SocketListeners.STATUS_CALL}');
            emit(CallCancelState());
          }
          if (status == CallStatus.end.name) {
            _homeCubit.currentCallStatus = CallStatus.end;
            SocketService.instance.socket.off(
                '${AuthRepo.instance.user.userId}-${SocketListeners.STATUS_CALL}');
            emit(CallEndState());
          }
        }
      });
    } catch (e) {
      debugPrint('');
    }
  }

  void emitStatusCall(
      {required CallModel callModel,
      required CallStatus status,
      required int current,
      required BuildContext context}) {
    Socket socket = SocketService.instance.socket;

    try {
      socket.emit(SocketEmit.STATUS_CALL, {
        'callId': callModel.callId,
        'status': status.name,
        'current': current
      });

      if (status.name == CallStatus.accept.name) {
        initAgoraAndJoinChannel(
            channelToken: callModel.token!,
            channelName: callModel.channelName!,
            isCaller: false,
            uId: callModel.receiverId!,
            context: context,
            callModel: callModel);
      } else if (status.name == CallStatus.unAnswer.name) {
        emit(SuccessUnAnsweredVideoChatState());
      }
    } catch (e) {
      debugPrint('');
    }
  }

  @override
  Future<void> close() {
    SocketService.instance.socket
        .off('${AuthRepo.instance.user.userId}-${SocketListeners.STATUS_CALL}');
    SocketService.instance.socket.clearListeners();
    return super.close();
  }

  void unsubscribeSocket() {
    SocketService.instance.socket
        .off('${AuthRepo.instance.user.userId}-${SocketListeners.STATUS_CALL}');
  }

  Future<bool> checkRatingRating(int userId, int bookingId) async {
    print('userId $userId');
    try {
      var data = FormData.fromMap({
        'user_id': userId,
        'booking_id': bookingId,
      });

      bool result = await HomeRepo.instance.checkRating(data);
      return result;
    } catch (e) {
      return false;
    }
  }
}
