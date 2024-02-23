class RecommendedQuestionModel {
  RecommendedQuestionModel({
    required this.id,
    required this.question,
    this.status,
    this.optional,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String question;
  int? status;
  bool? optional;
  String? createdAt;
  String? updatedAt;

  factory RecommendedQuestionModel.fromJson(Map<String, dynamic> json) =>
      RecommendedQuestionModel(
        id: json["id"],
        question: json["question"],
        status: json["status"],
        optional: json["optioanl"] ?? false,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "status": status,
        "optioanl": optional,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
