class CalendarDataModel {
  CalendarDataModel({
    required this.unavailableDate,
    required this.unavailableDay,
    required this.unavailableDayId,
    required this.userAppointment,
  });

  List<DateTime> unavailableDate;
  List<String> unavailableDay;
  List<int> unavailableDayId;
  List<DateTime> userAppointment;

  factory CalendarDataModel.fromJson(Map<String, dynamic> json) =>
      CalendarDataModel(
        unavailableDate: List<DateTime>.from(
            json[" unavailable_date"].map((x) => DateTime.parse(x))),
        unavailableDay:
            List<String>.from(json["unavailable_day"].map((x) => x)),
        unavailableDayId:
            List<int>.from(json["unavailable_day_id"].map((x) => x)),
        userAppointment: List<DateTime>.from(
            json["user_appointment"].map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        " unavailable_date": List<dynamic>.from(unavailableDate.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "unavailable_day": List<dynamic>.from(unavailableDay.map((x) => x)),
        "user_appointment": List<dynamic>.from(userAppointment.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
      };
}

//"data": List<dynamic>.from(data.map((x) => x.toJson())),
class CalendarDaysModel {
  CalendarDaysModel({
    required this.dayStatus,
    required this.date,
    required this.day,
    required this.dayShortDate,
    required this.dayShortName,
  });

  int dayStatus;
  DateTime date;
  String day;
  String dayShortDate;
  String dayShortName;

  factory CalendarDaysModel.fromJson(Map<String, dynamic> json) =>
      CalendarDaysModel(
        dayStatus: json["day_status"],
        date: DateTime.parse(json["date"]),
        day: json["day"],
        dayShortDate: json["dayShortDate"],
        dayShortName: json["dayShortName"],
      );

  Map<String, dynamic> toJson() => {
        "day_status": dayStatus,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "day": day,
        "dayShortDate": dayShortDate,
        "dayShortName": dayShortName,
      };
}
