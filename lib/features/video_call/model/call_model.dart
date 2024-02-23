import 'package:helpert_app/features/video_call/model/call_user_model.dart';

class CallModel {
  late String callId;
  String? token;
  String? channelName;
  int? callerId;
  String? callerName;
  String? callerAvatar;
  int? receiverId;
  int? userId;
  int? doctorId;
  int? bookingId;
  String? receiverName;
  String? receiverAvatar;
  String? receiverSpecialization;
  String? callerSpecialization;
  String? status;
  num? createAt;
  late int current;
  CallUser? otherUser; //UI

  CallModel(
      {required this.callId,
      this.channelName,
      this.token,
      this.callerId,
      required this.userId,
      required this.bookingId,
      required this.doctorId,
      this.callerName,
      this.callerAvatar,
      this.receiverId,
      this.receiverName,
      this.receiverAvatar,
      this.receiverSpecialization,
      this.callerSpecialization,
      this.status,
      this.createAt,
      required this.current});

  CallModel.fromJson(Map<String, dynamic> json) {
    callId = json['callId'] ?? '';
    token = json['token'];
    channelName = json['channelName'];
    callerId = json['callerId'];
    userId = json['userId'];
    doctorId = json['doctorId'];
    bookingId = json['bookingId'];
    callerName = json['callerName'] ?? '';
    callerAvatar = json['callerAvatar'] ?? "";
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    callerSpecialization = json['callerSpecialization'];
    receiverSpecialization = json['receiverSpecialization'];
    receiverAvatar = json['receiverAvatar'] ?? '';
    status = json['status'].toString();
    createAt = json['createAt'];
    current = json['current'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'channelName': channelName,
      'callerId': callerId,
      'doctorId': doctorId,
      'userId': userId,
      'bookingId': bookingId,
      'callerName': callerName,
      'callerAvatar': callerAvatar,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverAvatar': receiverAvatar,
      'receiverSpecialization': receiverSpecialization,
      'callerSpecialization': callerSpecialization,
      'status': status,
      'current': current
    };
  }
}
