import 'package:helpert_app/constants/asset_paths.dart';

class OnBoardingModel {
  final String title;
  final String description;
  final String image;

  OnBoardingModel(
      {required this.title, required this.description, required this.image});
}

List<OnBoardingModel> onboarding = [
  OnBoardingModel(
      title: 'Welcome to Helpert!',
      description:
          'Helpert help’s you to find and connect with Experts, Recruiters and Job seekers in vario us fields.',
      image: first_onboarding),
  OnBoardingModel(
      title: 'Connect with Expert',
      description:
          'Book an appointment and get consultation or advice on your career via videocall',
      image: second_onboarding),
  OnBoardingModel(
      title: 'Help & Earn money!',
      description:
          'Join Helpert and Become a Expert, Specialist or Recruiter to help people around the world and earn money',
      image: third_onboarding),
];
