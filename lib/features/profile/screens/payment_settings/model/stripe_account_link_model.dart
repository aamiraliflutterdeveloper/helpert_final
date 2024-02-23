class StripeAccountLinkModel {
  StripeAccountLinkModel({
    required this.object,
    required this.created,
    required this.expiresAt,
    required this.url,
  });

  String object;
  int created;
  int expiresAt;
  String url;

  factory StripeAccountLinkModel.fromJson(Map<String, dynamic> json) =>
      StripeAccountLinkModel(
        object: json["object"],
        created: json["created"],
        expiresAt: json["expires_at"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "created": created,
        "expires_at": expiresAt,
        "url": url,
      };
}
