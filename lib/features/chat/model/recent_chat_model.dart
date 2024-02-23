class RecentChatModel {
  RecentChatModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.attachment,
    required this.isSent,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.theuser,
    required this.user,
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
  int theuser;
  RecentChatUser user;

  factory RecentChatModel.fromJson(Map<String, dynamic> json) =>
      RecentChatModel(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        attachment: json["attachment"],
        isSent: json["is_sent"],
        isRead: json["is_read"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        theuser: json["theuser"],
        user: RecentChatUser.fromJson(json["user"]),
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
        "theuser": theuser,
        "user": user.toJson(),
      };
}

class RecentChatUser {
  RecentChatUser({
    required this.timezone,
    required this.sessionRate,
    required this.id,
    required this.email,
    required this.username,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.specialization,
    this.provider,
    this.uuid,
    required this.fcmToken,
    this.image,
    this.stripeId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.isProfile,
  });

  int id;
  String email;
  String username;
  int roleId;
  String firstName;
  String lastName;
  String timezone;
  String specialization;
  DateTime? dob;
  dynamic provider;
  dynamic uuid;
  String fcmToken;
  dynamic image;
  dynamic stripeId;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  int sessionRate;
  int isProfile;

  factory RecentChatUser.fromJson(Map<String, dynamic> json) => RecentChatUser(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        roleId: json["role_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        specialization: json["specialization"] ?? '',
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        provider: json["provider"],
        uuid: json["uuid"],
        fcmToken: json["fcm_token"] ?? '',
        image: json["image"],
        stripeId: json["stripe_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        isProfile: json["is_profile"],
        sessionRate: json["session_rate"] ?? 0,
        timezone: json["timezone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "specialization": specialization,
        "dob": dob == null
            ? null
            : "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "provider": provider,
        "uuid": uuid,
        "fcm_token": fcmToken,
        "image": image,
        "stripe_id": stripeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "is_profile": isProfile,
      };
}
