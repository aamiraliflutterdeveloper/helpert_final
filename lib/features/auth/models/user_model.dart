class UserModel {
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.timezone,
    required this.userName,
    required this.email,
    required this.stripeId,
    required this.availability,
    required this.fcmToken,
    required this.isProfileCompleted,
    required this.provider,
    required this.dob,
    required this.profession,
    required this.specialization,
    required this.other_specialization,
    required this.company,
    required this.experience,
    required this.expertise,
    required this.city,
    required this.country,
    required this.lat,
    required this.lng,
    required this.interests,
    required this.interestList,
    required this.specializationList,
    required this.iAmList,
    required this.companyList,
    required this.location,
    this.followers = 0,
    this.following = 0,
    this.sessionRate,
    required this.booked,
    required this.joining_date,
    required this.description,
    required this.image,
    required this.date_of_birthday,
    required this.userDetailList,
    required this.iam,
    required this.start_date,
    required this.userRole,
    required this.userSecondDetailLIst,
    this.isFollow = false,
    required this.end_date,
    required this.userId,
    required this.rating,
    required this.payment_status,
  });

  String firstName;
  String lastName;
  String timezone;
  String userName;
  String email;
  String stripeId;
  int availability;
  String fcmToken;
  int isProfileCompleted;
  String provider;
  String dob;
  String profession;
  String specialization;
  String other_specialization;
  String company;
  String experience;
  String expertise;
  String city;
  String country;
  String lat;
  String lng;
  List<ListItem> interests;
  List<ListItem> interestList;
  List<ListItem> specializationList;
  List<ListItem> iAmList;
  List<ListItem> companyList;
  List<UserDetail> userDetailList;
  List<UserDetailListElement> userSecondDetailLIst;
  String location;
  String joining_date;
  int followers;
  int following;
  int? sessionRate;
  int booked;
  String description;
  String image;
  String date_of_birthday;
  String iam;
  String start_date;
  String end_date;
  int userRole;
  bool isFollow;
  int userId;
  double rating;
  String payment_status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['user_id'] ?? 0,
        firstName: json["first_name"] ?? '',
        timezone: json["timezone"] ?? '',
        lastName: json["last_name"] ?? '',
        userName: json["username"] ?? '',
        email: json["email"] ?? '',
        stripeId: json["stripe_id"] ?? '',
        booked: json["booked"] ?? 0,
        availability: json["availability"] ?? 0,
        fcmToken: json["fcm_token"] ?? '',
        isProfileCompleted: json["is_profile_complete"] ?? 0,
        provider: json["provider"] ?? '',
        dob: json["dob"] ?? '',
        profession: json["profession"] ?? '',
        specialization: json["specialization"] ?? '',
        other_specialization: json["other_specialization"] ?? '',
        company: json["company"] ?? '',
        experience: json["experience"] ?? '',
        expertise: json["expertise"] ?? '',
        city: json["city"] ?? '',
        country: json["country"] ?? '',
        lat: json["lat"] ?? '',
        lng: json["lng"] ?? '',
        rating: json["rating"] == 0 || json["rating"] == null
            ? 0.0
            : json["rating"],
        interests: json["interests"] != null
            ? List<ListItem>.from(
                json["interests"].map((x) => ListItem.fromJson(x)))
            : [],
        interestList: json["interest_list"] != null
            ? List<ListItem>.from(
                json["interest_list"].map((x) => ListItem.fromJson(x)))
            : [],
        specializationList: json["specialization_list"] != null
            ? List<ListItem>.from(
                json["specialization_list"].map((x) => ListItem.fromJson(x)))
            : [],
        iAmList: json["iam_list"] != null
            ? List<ListItem>.from(
                json["iam_list"].map((x) => ListItem.fromJson(x)))
            : [],
        companyList: json["company_list"] != null
            ? List<ListItem>.from(
                json["company_list"].map((x) => ListItem.fromJson(x)))
            : [],
        location: json['location'] ?? '',
        joining_date: json['joining_date'] ?? '',
        followers: json['followers'] ?? 0,
        following: json['following'] ?? 0,
        sessionRate: json['session_rate'],
        description: json['description'] ?? '',
        image: json['image'] ?? '',
        date_of_birthday: json['date_of_birthday'] ?? '',
        userDetailList: json["user_detail"] != null
            ? List<UserDetail>.from(
                json["user_detail"].map((x) => UserDetail.fromJson(x)))
            : [],
        userSecondDetailLIst: json["user_detail_list"] != null
            ? List<UserDetailListElement>.from(json["user_detail_list"]
                .map((x) => UserDetailListElement.fromJson(x)))
            : [],
        iam: json['iam'] ?? '',
        start_date: json['start_date'] ?? '',
        end_date: json['end_date'] ?? '',
        userRole: json['user_role'] ?? 0,
        isFollow: json['is_follow'] ?? false,
        payment_status: json['payment_status'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        "first_name": firstName,
        "last_name": lastName,
        "username": userName,
        "email": email,
        "fcm_token": fcmToken,
        "is_profile_complete": isProfileCompleted,
        "provider": provider,
        "dob": dob,
        "profession": profession,
        "specialization": specialization,
        "other_specialization": other_specialization,
        "company": company,
        "experience": experience,
        "expertise": expertise,
        "city": city,
        "country": country,
        "lat": lat,
        "lng": lng,
        "interests": interests,
        "interest_list": interestList,
        "iam_list": iAmList,
        "specialization_list": specializationList,
        "company_list": companyList,
        'location': location,
        'joining_date': joining_date,
        'followers': followers,
        'following': following,
        'session_rate': sessionRate ?? 0,
        'booked': booked,
        'description': description,
        'image': image,
        'date_of_birthday': date_of_birthday,
        'iam': iam,
        'start_date': start_date,
        'end_date': end_date,
        'user_role': userRole,
        'is_follow': isFollow,
        'availability': availability,
        'stripe_id': stripeId,
      };
}

class ListItem {
  ListItem({
    required this.id,
    required this.name,
    required this.icon,
  });

  int id;
  String name;
  String icon;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        id: json["id"],
        name: json["name"],
        icon: json["interestIcon"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class UserDetail {
  UserDetail({
    required this.iam,
    required this.specialization,
    required this.company,
    required this.experience,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    // required this.currentlyWorking,
  });

  String iam;
  String specialization;
  String company;
  String experience;
  String description;
  String location;
  DateTime startDate;
  String? endDate;

  // String currentlyWorking;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        iam: json["iam"],
        specialization: json["specialization"],
        company: json["company"],
        experience: json["experience"],
        description: json["description"],
        location: json["location"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: json["end_date"] ?? '',
        // currentlyWorking: json["currently_working"],
      );

  Map<String, dynamic> toJson() => {
        "iam": iam,
        "specialization": specialization,
        "company": company,
        "experience": experience,
        "description": description,
        "location": location,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        // "currently_working": currentlyWorking,
      };
}

// class UserDetailList {
//   UserDetailList({
//     required this.userDetailList,
//   });
//
//   List<UserDetailListElement> userDetailList;
//
//   factory UserDetailList.fromJson(Map<String, dynamic> json) => UserDetailList(
//         userDetailList: List<UserDetailListElement>.from(
//             json["user_detail_list"]
//                 .map((x) => UserDetailListElement.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user_detail_list":
//             List<dynamic>.from(userDetailList.map((x) => x.toJson())),
//       };
// }

class UserDetailListElement {
  UserDetailListElement(
      {required this.id,
      this.expertise,
      this.specialization,
      this.specializationId,
      this.company,
      this.experience,
      this.description,
      this.location,
      this.joiningDate,
      this.endDate,
      this.userId,
      this.currentlyWorking,
      this.companyId,
      this.iamId,
      this.specializations,
      this.companys,
      this.iam,
      required this.joining_date,
      required this.end_date});

  int id;
  String? expertise;
  String? specialization;
  int? specializationId;
  String? company;
  String? experience;
  String? description;
  String? location;
  String? joiningDate;
  String? endDate;
  int? userId;
  int? currentlyWorking;
  int? companyId;
  int? iamId;
  Companys? specializations;
  Companys? companys;
  Companys? iam;
  String joining_date;
  String end_date;

  factory UserDetailListElement.fromJson(Map<String, dynamic> json) =>
      UserDetailListElement(
        id: json["id"],
        expertise: json["expertise"],
        specialization: json["specialization"],
        specializationId: json["specialization_id"],
        company: json["company"],
        experience: json["experience"],
        description: json["description"],
        location: json["location"],
        joiningDate: json["joining_date"],
        endDate: json["end_date"],
        userId: json["user_id"],
        currentlyWorking: json["currently_working"],
        companyId: json["company_id"],
        iamId: json["iam_id"],
        specializations: Companys.fromJson(json["specializations"]),
        companys: Companys.fromJson(json["companys"]),
        iam: Companys.fromJson(json["iam"]),
        joining_date: json['joining_date'] ?? '',
        end_date: json['end_date'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "expertise": expertise,
        "specialization": specialization,
        "specialization_id": specializationId,
        "company": company,
        "experience": experience,
        "description": description,
        "location": location,
        // "joining_date":
        //     "${joiningDate.year.toString().padLeft(4, '0')}-${joiningDate.month.toString().padLeft(2, '0')}-${joiningDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "user_id": userId,
        "currently_working": currentlyWorking,
        "company_id": companyId,
        "iam_id": iamId,
        "specializations": specializations!.toJson(),
        "companys": companys!.toJson(),
        "iam": iam!.toJson(),
        "joining_date": joining_date
      };
}

class Companys {
  Companys({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Companys.fromJson(Map<String, dynamic> json) => Companys(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
