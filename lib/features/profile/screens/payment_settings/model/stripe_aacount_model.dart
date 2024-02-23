class StripeAccountModel {
  StripeAccountModel({
    required this.id,
    required this.object,
    this.businessType,
    required this.chargesEnabled,
    required this.country,
    required this.created,
    required this.defaultCurrency,
    required this.detailsSubmitted,
    required this.email,
    required this.payoutsEnabled,
    required this.type,
  });

  String id;
  String object;
  String? businessType;
  bool chargesEnabled;
  String country;
  int created;
  String defaultCurrency;
  bool detailsSubmitted;
  String email;
  bool payoutsEnabled;
  String type;

  factory StripeAccountModel.fromJson(Map<String, dynamic> json) =>
      StripeAccountModel(
        id: json["id"],
        object: json["object"],
        businessType: json["business_type"],
        chargesEnabled: json["charges_enabled"],
        country: json["country"],
        created: json["created"],
        defaultCurrency: json["default_currency"],
        detailsSubmitted: json["details_submitted"],
        email: json["email"],
        payoutsEnabled: json["payouts_enabled"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "business_type": businessType,
        "charges_enabled": chargesEnabled,
        "country": country,
        "created": created,
        "default_currency": defaultCurrency,
        "details_submitted": detailsSubmitted,
        "email": email,
        "payouts_enabled": payoutsEnabled,
        "type": type,
      };
}
