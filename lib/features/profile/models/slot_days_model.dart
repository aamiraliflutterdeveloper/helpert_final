class DaysListModel {
  DaysListModel({
    required this.days,
  });

  List<DaysModel> days;

  factory DaysListModel.fromJson(Map<String, dynamic> json) => DaysListModel(
        days: List<DaysModel>.from(
            json["daySlot"].map((x) => DaysModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "daySlot": List<dynamic>.from(days.map((x) => x.toJson())),
      };
}

class DaysModel {
  DaysModel({
    this.sessionRate,
    this.userId,
    required this.dayId,
    required this.status,
    required this.bookingStatus,
    required this.name,
    required this.slots,
  });

  int? sessionRate;
  int? userId;
  int dayId;
  int status;
  int bookingStatus;
  String name;
  List<SlotModel> slots;

  factory DaysModel.fromJson(Map<String, dynamic> json) => DaysModel(
        sessionRate: json["session_rate"],
        userId: json["user_id"],
        dayId: json["day_id"],
        status: json["status"] ?? 0,
        bookingStatus: json["booking_status"] ?? 0,
        name: json["name"],
        slots: List<SlotModel>.from(
            json["slots"].map((x) => SlotModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "day_id": dayId,
        "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
      };
}

class SlotModel {
  SlotModel({
    required this.slotId,
    required this.slotTime,
    this.status,
    this.bookingStatus,
  });

  int slotId;
  String slotTime;
  int? status;
  int? bookingStatus;

  factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
        slotId: json["slot_id"],
        slotTime: json["slot_time"],
        status: json["status"],
        bookingStatus: json["booking_status"],
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
      };
}
