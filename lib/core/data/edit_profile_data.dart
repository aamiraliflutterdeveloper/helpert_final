import '../../constants/asset_paths.dart';

class EditProfile {
  String title;
  String subTitle;
  String image;
  EditProfile(
      {required this.image, required this.subTitle, required this.title});
}

List<EditProfile> userProfilesList = [
  EditProfile(
      image: account_icon,
      subTitle: 'Edit your personal info',
      title: 'Account'),
  EditProfile(
      image: schedule_icon,
      subTitle: 'Show your availability time',
      title: 'My Schedule'),
  EditProfile(
      image: session_rate_icon,
      subTitle: 'Per consultation charges',
      title: 'Session rate'),
  EditProfile(
      image: portfolio_icon,
      subTitle: 'Manage Specialisation & work history',
      title: 'Experience & Portfolios'),
  EditProfile(
      image: payment_icon,
      subTitle: 'Change your payment settings',
      title: 'Payment Settings'),
  EditProfile(
      image: earnings_icon,
      subTitle: 'Your total earnings',
      title: 'My Earnings'),
];
