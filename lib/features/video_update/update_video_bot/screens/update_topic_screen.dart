// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/video/model/videos_model.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../../../../common_widgets/cancel_publisher_topbar.dart';
// import '../../../../core/data/video_data.dart';
// import '../widgets/update_topic_card.dart';
//
// class UpdateTopicScreen extends StatefulWidget {
//   final VideoBotModel videoBot;
//   const UpdateTopicScreen({Key? key, required this.videoBot}) : super(key: key);
//
//   @override
//   _UpdateTopicScreenState createState() => _UpdateTopicScreenState();
// }
//
// class _UpdateTopicScreenState extends State<UpdateTopicScreen> {
//   bool disable = false;
//
//   @override
//   void initState() {
//     VideoModule.topic.clear();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           CancelPublishTopBar(
//             onTap: () {
//               NavRouter.pop(context);
//             },
//           ),
//           UpdateTopicCard(disable: disable, videoBot: widget.videoBot),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
