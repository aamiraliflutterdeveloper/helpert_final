import 'package:helpert_app/constants/asset_paths.dart';

class NavBarItemModel {
  final String title;
  final String icon;
  NavBarItemModel({required this.title, required this.icon});
}

List<NavBarItemModel> navBarItems = [
  NavBarItemModel(title: 'Home', icon: ic_home),
  NavBarItemModel(title: 'Meetings', icon: ic_appointment),
  NavBarItemModel(title: 'Messages', icon: ic_message),
  NavBarItemModel(title: 'Messages', icon: ic_message),
  NavBarItemModel(title: 'Profile', icon: ic_profile),
];
