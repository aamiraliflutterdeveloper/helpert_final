class UnavailableDateListModel {
  UnavailableDateListModel({
    required this.unavailableDateList,
  });

  List<UnavailableDateModel> unavailableDateList;

  factory UnavailableDateListModel.fromJson(Map<String, dynamic> json) =>
      UnavailableDateListModel(
        unavailableDateList: List<UnavailableDateModel>.from(
            json["saveUser_offDays"]
                .map((x) => UnavailableDateModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "saveUser_offDays":
            List<dynamic>.from(unavailableDateList.map((x) => x.toJson())),
      };
}

class UnavailableDateModel {
  UnavailableDateModel({
    this.id,
    required this.startDate,
    required this.endDate,
    this.status,
    this.userId,
  });

  int? id;
  String startDate;
  String endDate;
  int? status;
  int? userId;

  factory UnavailableDateModel.fromJson(Map<String, dynamic> json) =>
      UnavailableDateModel(
        id: json["id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        status: json["status"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate,
        "end_date": endDate,
        "status": status,
        "user_id": userId,
      };
}
