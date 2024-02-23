class SocialUserModel {
  SocialUserModel({
    required this.uuid,
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.imageUrl,
    required this.provider,
    required this.email,
    required this.fcmToken,
  });

  String uuid;
  int type;
  String firstName;
  String lastName;
  String fullName;
  String imageUrl;
  String provider;
  String email;
  String? fcmToken;

  factory SocialUserModel.fromJson(Map<String, dynamic> json) =>
      SocialUserModel(
        uuid: json["uuid"],
        type: json["type"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["full_name"],
        imageUrl: json["image_url"],
        provider: json["provider"],
        email: json["email"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "type": type,
        "firstName": firstName,
        "lastName": lastName,
        "full_name": fullName,
        "image_url": imageUrl,
        "provider": provider,
        "email": email,
        "fcm_token": fcmToken,
      };
}
