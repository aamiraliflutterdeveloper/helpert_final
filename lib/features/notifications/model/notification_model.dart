import 'package:helpert_app/features/appointment/model/appointment_model.dart';

class NotificationModel {
  NotificationModel({
    required this.notificationId,
    required this.status,
    required this.timezone,
    required this.sessionRate,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.read,
    required this.title,
    required this.time,
    required this.message,
    required this.type,
    required this.senderId,
    required this.receiverId,
    required this.username,
    required this.appointmentDetail,
    required this.videobot_id,
    required this.specialization,
  });

  int notificationId;
  int status;
  int read;
  int sessionRate;
  String title;
  String time;
  String timezone;
  String message;
  String type;
  String image;
  String firstName;
  String lastName;
  int senderId;
  int receiverId;
  String username;
  int videobot_id;
  String specialization;
  AppointmentModel? appointmentDetail;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationId: json["notification_id"],
        status: json["status"],
        timezone: json["timezone"] ?? '',
        sessionRate: json["sessionrate"] ?? 0,
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        image: json["image"] ?? '',
        read: json["read"],
        title: json["title"],
        time: json["time"],
        message: json["message"],
        type: json["type"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        username: json["username"],
        videobot_id: json['videobot_id'] ?? -1,
        specialization: json['specialization'] ?? '',
        appointmentDetail: json['booking_detail'] != null
            ? AppointmentModel.fromJson(json['booking_detail'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "status": status,
        "read": read,
        "title": title,
        "time": time,
        "message": message,
        "type": type,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "username": username,
        "booking_detail":
            appointmentDetail != null ? appointmentDetail!.toJson() : null,
      };
}
