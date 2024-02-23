import 'package:helpert_app/features/auth/repo/auth_repo.dart';

class Chat {
  Chat({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.attachment,
    required this.isSent,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    this.isMe = false,
  });

  int id;
  int senderId;
  int receiverId;
  String message;
  dynamic attachment;
  int isSent;
  int isRead;
  DateTime createdAt;
  DateTime updatedAt;
  bool isMe;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        attachment: json["attachment"],
        isSent: json["is_sent"],
        isRead: json["is_read"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isMe: AuthRepo.instance.user.userId == json['id'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "attachment": attachment,
        "is_sent": isSent,
        "is_read": isRead,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
