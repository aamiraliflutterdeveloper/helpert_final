class BookingModel {
  BookingModel({
    required this.doctorId,
    required this.bookingUserId,
    required this.dayId,
    required this.slotId,
    required this.bookingDate,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.paymentType,
    required this.amount,
    required this.stripChargeId,
    this.slotTime,
  });

  int doctorId;
  int bookingUserId;
  int dayId;
  int slotId;
  DateTime bookingDate;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String paymentType;
  int amount;
  String stripChargeId;
  String? slotTime;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        doctorId: json["doctor_id"],
        bookingUserId: json["booking_user_id"],
        dayId: json["day_id"],
        slotId: json["slot_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        paymentType: json["payment_type"],
        amount: json["amount"],
        stripChargeId: json["strip_charge_id"],
        slotTime: json["slot"] != null ? json["slot"]['slot_time'] : '',
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "booking_user_id": bookingUserId,
        "day_id": dayId,
        "slot_id": slotId,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "payment_type": paymentType,
        "amount": amount,
        "strip_charge_id": stripChargeId,
      };
}
