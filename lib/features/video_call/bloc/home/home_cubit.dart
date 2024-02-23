import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../constants/consts.dart';
import '../../../../core/services/socket_service.dart';
import '../../../auth/repo/auth_repo.dart';
import '../../model/call_model.dart';
import 'home_state.dart';

enum HomeTypes { Users, History }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  CallStatus? currentCallStatus;

  void emitStartCall({required CallModel callModel, bool receiver = false}) {
    Socket socket = SocketService.instance.socket;
    emit(LoadingFireVideoCallState());
    debugPrint('receiver $receiver');
    debugPrint('receiver ${callModel.toMap()}');
    try {
      socket.emit(SocketEmit.START_CALL, {
        'is_receiver': receiver,
        'token': callModel.token,
        'callId': callModel.callId,
        'channelName': callModel.channelName,
        'callerId': callModel.callerId,
        'userId': callModel.userId,
        'doctorId': callModel.doctorId,
        'bookingId': callModel.bookingId,
        'callerName': callModel.callerName,
        'callerAvatar': callModel.callerAvatar,
        'receiverId': callModel.receiverId,
        'receiverName': callModel.receiverName,
        'receiverAvatar': callModel.receiverAvatar,
        'receiverSpecialization': callModel.receiverSpecialization,
        'callerSpecialization': callModel.callerSpecialization,
        'status': callModel.status,
        'current': callModel.current
      });
      if (!receiver) emit(SuccessFireVideoCallState(callModel: callModel));
    } catch (e) {
      emit(ErrorFireVideoCallState(e.toString()));
    }
  }

  void listenToStartCall() {
    Socket socket = SocketService.instance.socket;

    try {
      socket.on(
        '${AuthRepo.instance.user.userId.toString()}-${SocketListeners.START_CALL}',
        (data) {
          if (data['result'] == 'success') {
            CallModel incomingCall = CallModel.fromJson(data['data']);
            if (incomingCall.receiverId.toString() ==
                    AuthRepo.instance.user.userId.toString() &&
                incomingCall.current == 1) {
              String? status = incomingCall.status;
              if (status == CallStatus.ringing.name) {
                currentCallStatus = CallStatus.ringing;
                emit(SuccessInComingCallState(callModel: incomingCall));
              }
            }
          } else {
            emit(ErrorFireVideoCallState(data['message']));
          }
        },
      );
    } catch (e) {
      debugPrint('');
    }
  }

  @override
  Future<void> close() {
    SocketService.instance.socket
        .off('${AuthRepo.instance.user.userId}-${SocketListeners.START_CALL}');
    SocketService.instance.socket.clearListeners();
    return super.close();
  }

  void unsubscribeSocket() {
    SocketService.instance.socket
        .off('${AuthRepo.instance.user.userId}-${SocketListeners.START_CALL}');
  }

  // final _homeApi = HomeApi();
  //
  // List<CallModel> calls = [];
  //
  // void getCallHistoryRealTime() {
  //   emit(LoadingGetCallHistoryState());
  //   _homeApi.getCallHistoryRealTime().onData((data) {
  //     if (data.size != 0) {
  //       calls = []; // for realtime update the list
  //       for (var element in data.docs) {
  //         if (element.data()['callerId'] == AuthRepo.instance.user.userId ||
  //             element.data()['receiverId'] == AuthRepo.instance.user.userId) {
  //           //As firebase not allow multi where query, so we get all calls and filter it
  //           if (!calls.any((e) => e.id == element.id)) {
  //             var call = CallModel.fromJson(element.data());
  //             if (call.callerId == AuthRepo.instance.user.userId) {
  //               call.otherUser = CallUser(
  //                   name: call.receiverName!, avatar: call.receiverAvatar!);
  //             } else {
  //               call.otherUser = CallUser(
  //                   name: call.callerName!, avatar: call.callerAvatar!);
  //             }
  //             calls.add(call);
  //           }
  //         }
  //       }
  //       emit(SuccessGetCallHistoryState());
  //     } else {
  //       emit(ErrorGetCallHistoryState('No Call History'));
  //     }
  //   });
  // }
  //
  // //#endregion
  //
  // //Call Logic ________________________________
  // final _callApi = CallApi();
  // bool fireCallLoading = false;
  // Future<void> fireVideoCall({required CallModel callModel}) async {
  //   fireCallLoading = true;
  //   emit(LoadingFireVideoCallState());
  //   //1-generate call token
  //   Map<String, dynamic> queryMap = {
  //     'channelName': 'channel_${UniqueKey().hashCode.toString()}',
  //     'uid': callModel.callerId,
  //   };
  //   fireCallLoading = false;
  //   callModel.token = agoraTestToken;
  //   callModel.channelName = agoraTestChannelName;
  //   postCallToFirestore(callModel: callModel);
  //   emit(ErrorFireVideoCallState(onError.toString()));
  //   // _callApi.generateCallToken(queryMap: queryMap).then((value) {
  //   //   callModel.token = value['token'];
  //   //   callModel.channelName = value['channel_name'];
  //   //   //2-post call in Firebase
  //   //   postCallToFirestore(callModel: callModel);
  //   // }).catchError((onError) {
  //   //   fireCallLoading = false;
  //   //   //For test
  //   //   callModel.token = agoraTestToken;
  //   //   callModel.channelName = agoraTestChannelName;
  //   //   postCallToFirestore(callModel: callModel);
  //   //   emit(ErrorFireVideoCallState(onError.toString()));
  //   // });
  // }

  // void postCallToFirestore({required CallModel callModel}) {
  //   _callApi.postCallToFirestore(callModel: callModel).then((value) {
  //     //3-update user busy status in Firebase
  //     emit(SuccessFireVideoCallState(callModel: callModel));
  //     //sendNotificationForIncomingCall(callModel: callModel);
  //   }).catchError((onError) {
  //     fireCallLoading = false;
  //     emit(ErrorPostCallToFirestoreState(onError.toString()));
  //   });
  // }
  //
  // void sendNotificationForIncomingCall({required CallModel callModel}) {
  //   FirebaseFirestore.instance
  //       .collection(tokensCollection)
  //       .doc(callModel.receiverId.toString())
  //       .get()
  //       .then((value) {
  //     if (value.exists) {
  //       Map<String, dynamic> bodyMap = {
  //         'type': 'call',
  //         'title': 'New call',
  //         'body': jsonEncode(callModel.toMap())
  //       };
  //
  //       // DioHelper.postData(
  //       //   data: fcmSendData.toMap(),
  //       //   baseUrl: 'https://fcm.googleapis.com/',
  //       //   endPoint: 'fcm/send',
  //       // ).then((value) {
  //       //   emit(SuccessFireVideoCallState(callModel: callModel));
  //       // }).catchError((onError) {
  //       //   fireCallLoading = false;
  //       //   emit(ErrorSendNotification(onError.toString()));
  //       // });
  //     }
  //   }).catchError((onError) {
  //     fireCallLoading = false;
  //     emit(ErrorSendNotification(onError.toString()));
  //   });
  // }
  // CallModel inComingCall;

  // void listenToInComingCalls() {
  //   _callApi.listenToInComingCall().onData((data) {
  //     if (data.size != 0) {
  //       for (var element in data.docs) {
  //         if (element.data()['current'] == true) {
  //           String status = element.data()['status'];
  //           if (status == CallStatus.ringing.name) {
  //             currentCallStatus = CallStatus.ringing;
  //             emit(SuccessInComingCallState(
  //                 callModel: CallModel.fromJson(element.data())));
  //           }
  //         }
  //       }
  //     }
  //   });
  // }
}
