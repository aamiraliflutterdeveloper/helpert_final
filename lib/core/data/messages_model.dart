import '../../constants/asset_paths.dart';

class MessagesModel {
  String title;
  String subTitle;
  String profilePhoto;
  bool isRead;
  MessagesModel(
      {this.isRead = false,
      required this.profilePhoto,
      required this.subTitle,
      required this.title});
}

List<MessagesModel> userMessagesList = [
  MessagesModel(
    title: 'Jacob Jones',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_1,
    isRead: true,
  ),
  MessagesModel(
    title: 'Jacob Jones',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_1,
    isRead: false,
  ),
  MessagesModel(
    title: 'Wade Warren',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_2,
    isRead: false,
  ),
  MessagesModel(
    title: 'Jacob Jones',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_1,
    isRead: false,
  ),
  MessagesModel(
    title: 'Jane Cooper',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_3,
    isRead: true,
  ),
  MessagesModel(
    title: 'Leslie Alexander',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_4,
    isRead: false,
  ),
  MessagesModel(
    title: 'Brooklyn Simmons',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_5,
    isRead: false,
  ),
  MessagesModel(
    title: 'Jacob Jones',
    subTitle: 'Let’s start by adjusting your diet...',
    profilePhoto: user_4,
    isRead: false,
  ),
];
