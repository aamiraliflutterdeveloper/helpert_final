import 'package:helpert_app/features/auth/models/user_model.dart';

class AllListModel {
  AllListModel({
    required this.iamListing,
    required this.companyListing,
    required this.specializationListing,
  });

  List<ListItem> iamListing;
  List<ListItem> companyListing;
  List<ListItem> specializationListing;

  factory AllListModel.fromJson(Map<String, dynamic> json) => AllListModel(
        iamListing: List<ListItem>.from(
            json["iam_listing"].map((x) => ListItem.fromJson(x))),
        companyListing: List<ListItem>.from(
            json["company_listing"].map((x) => ListItem.fromJson(x))),
        specializationListing: List<ListItem>.from(
            json["specialization_listing"].map((x) => ListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "iam_listing": List<dynamic>.from(iamListing.map((x) => x.toJson())),
        "company_listing":
            List<dynamic>.from(companyListing.map((x) => x.toJson())),
        "specialization_listing":
            List<dynamic>.from(specializationListing.map((x) => x.toJson())),
      };
}
