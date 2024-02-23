// // To parse this JSON data, do
// //
// //     final slotDaysModel = slotDaysModelFromJson(jsonString);
//
// import 'dart:convert';
//
// SlotDaysModel slotDaysModelFromJson(String str) =>
//     SlotDaysModel.fromJson(json.decode(str));
//
// String slotDaysModelToJson(SlotDaysModel data) => json.encode(data.toJson());
//
// class SlotDaysModel {
//   SlotDaysModel({
//     this.result,
//     this.message,
//     this.data,
//   });
//
//   String result;
//   String message;
//   List<Datum> data;
//
//   factory SlotDaysModel.fromJson(Map<String, dynamic> json) => SlotDaysModel(
//         result: json["result"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "result": result,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

class AppointmentModel {
  AppointmentModel({
    required this.bookingId,
    required this.sessionRate,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.timezone,
    required this.feeInformation,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.specialization,
    required this.userDescription,
    required this.appointmentDescription,
    required this.userLocation,
    required this.day,
  });

  int bookingId;
  int status;
  String feeInformation;
  String startTime;
  String firstName;
  String lastName;
  String timezone;
  String endTime;
  String day;
  DateTime date;
  int userId;
  int sessionRate;
  String userName;
  String? userImage;
  String? specialization;
  String userDescription;
  String appointmentDescription;
  String userLocation;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        bookingId: json["booking_id"] ?? 0,
        status: json["status"] ?? 0,
        feeInformation: json["fee_information"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        timezone: json["timezone"] ?? '',
        startTime: json["start_time"],
        endTime: json["end_time"],
        date: DateTime.parse(json["date"]),
        userId: json["user_id"] ?? 0,
        sessionRate: json["sessionrate"] ?? 0,
        userName: json["user_name"] ?? '',
        userImage: json["user_image"],
        specialization: json["specialization"] ?? '',
        userDescription: json["user_disrecption"] ?? '',
        appointmentDescription: json["description"] ?? '',
        userLocation: json["user_location"] ?? '',
        day: json["day"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "status": status,
        "fee_information": feeInformation,
        "slot_time": startTime,
        "end_time": endTime,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "user_name": userName,
        "user_image": userImage,
        "specialization": specialization,
        "user_disrecption": userDescription,
        "description": appointmentDescription,
        "user_location": userLocation,
        "day": day,
      };
}
