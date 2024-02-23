import '../../constants/asset_paths.dart';

class ManageVideoBotsData {
  String title;
  String subTitle;
  String image;
  String status;
  bool isSuccess;
  ManageVideoBotsData(
      {required this.title,
      required this.image,
      required this.subTitle,
      required this.status,
      required this.isSuccess});
}

List<ManageVideoBotsData> manageVideoBots = [
  ManageVideoBotsData(
    title: 'Topic',
    status: 'Published',
    image: video_bots_user_image,
    subTitle: 'Knee pain in older people',
    isSuccess: true,
  ),
  ManageVideoBotsData(
    title: 'Topic',
    status: 'Published',
    image: video_bots_user_image,
    subTitle: 'Knee pain in older people',
    isSuccess: true,
  ),
  ManageVideoBotsData(
    title: 'Topic',
    status: 'Published',
    image: video_bots_user_image,
    subTitle: 'Knee pain in older people',
    isSuccess: true,
  ),
  ManageVideoBotsData(
    title: 'Topic',
    status: 'Published',
    image: video_bots_user_image,
    subTitle: 'Knee pain in older people',
    isSuccess: true,
  ),
  ManageVideoBotsData(
    title: 'Topic',
    status: 'In Drafts',
    image: video_bots_user_image,
    subTitle: 'Why do older people gets Knee pain?',
    isSuccess: false,
  ),
  ManageVideoBotsData(
      title: 'Topic',
      status: 'In Drafts',
      image: video_bots_user_image,
      subTitle: 'RLD Rest Less Leg Syndrome',
      isSuccess: false),
];
