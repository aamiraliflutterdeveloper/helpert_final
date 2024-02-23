// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/video/model/videos_model.dart';
//
// import '../../../../common_widgets/cancel_publisher_topbar.dart';
// import '../../../../core/data/video_data.dart';
// import '../widgets/update_intro_video_card.dart';
//
// class UpdateIntroVideoScreen extends StatefulWidget {
//   final VideoBotModel videoBot;
//   const UpdateIntroVideoScreen({Key? key, required this.videoBot})
//       : super(key: key);
//
//   @override
//   State<UpdateIntroVideoScreen> createState() => _UpdateIntroVideoScreenState();
// }
//
// class _UpdateIntroVideoScreenState extends State<UpdateIntroVideoScreen> {
//   bool disable = false;
//
//   @override
//   void initState() {
//     VideoModule.introVideo.clear();
//     VideoModule.defaultVideo.clear();
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
//               Navigator.pop(context);
//             },
//           ),
//           UpdateIntroVideoCard(disable: disable, videoBot: widget.videoBot),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
