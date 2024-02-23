// MyEarningModel myEarningModelFromJson(String str) =>
//     MyEarningModel.fromJson(json.decode(str));
//
// String myEarningModelToJson(MyEarningModel data) => json.encode(data.toJson());

// class MyEarningModel {
//   MyEarningModel({
//     required this.result,
//     required this.message,
//     required this.data,
//   });
//
//   String result;
//   String message;
//   Data data;
//
//   factory MyEarningModel.fromJson(Map<String, dynamic> json) => MyEarningModel(
//         result: json["result"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "result": result,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

class MyEarningModel {
  MyEarningModel({
    required this.object,
    required this.available,
    required this.connectReserved,
    required this.livemode,
    required this.pending,
  });

  String object;
  List<Available> available;
  List<ConnectReserved> connectReserved;
  bool livemode;
  List<Available> pending;

  factory MyEarningModel.fromJson(Map<String, dynamic> json) => MyEarningModel(
        object: json["object"],
        available: List<Available>.from(
            json["available"].map((x) => Available.fromJson(x))),
        connectReserved: List<ConnectReserved>.from(
            json["connect_reserved"].map((x) => ConnectReserved.fromJson(x))),
        livemode: json["livemode"],
        pending: List<Available>.from(
            json["pending"].map((x) => Available.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "available": List<dynamic>.from(available.map((x) => x.toJson())),
        "connect_reserved":
            List<dynamic>.from(connectReserved.map((x) => x.toJson())),
        "livemode": livemode,
        "pending": List<dynamic>.from(pending.map((x) => x.toJson())),
      };
}

class Available {
  Available({
    required this.amount,
    required this.currency,
    required this.sourceTypes,
  });

  int amount;
  String currency;
  SourceTypes sourceTypes;

  factory Available.fromJson(Map<String, dynamic> json) => Available(
        amount: json["amount"],
        currency: json["currency"],
        sourceTypes: SourceTypes.fromJson(json["source_types"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
        "source_types": sourceTypes.toJson(),
      };
}

class SourceTypes {
  SourceTypes({
    required this.card,
  });

  int card;

  factory SourceTypes.fromJson(Map<String, dynamic> json) => SourceTypes(
        card: json["card"],
      );

  Map<String, dynamic> toJson() => {
        "card": card,
      };
}

class ConnectReserved {
  ConnectReserved({
    required this.amount,
    required this.currency,
  });

  int amount;
  String currency;

  factory ConnectReserved.fromJson(Map<String, dynamic> json) =>
      ConnectReserved(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}
