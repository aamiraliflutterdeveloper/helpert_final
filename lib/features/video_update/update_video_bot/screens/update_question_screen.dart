// import 'package:flutter/material.dart';
// import 'package:helpert_app/features/video/model/videos_model.dart';
//
// import '../../../../common_widgets/cancel_publisher_topbar.dart';
// import '../../../../core/data/video_data.dart';
// import '../../../../utils/nav_router.dart';
// import '../widgets/update_question_card.dart';
//
// class UpdateQuestionScreen extends StatefulWidget {
//   final VideoBotModel videoBot;
//   const UpdateQuestionScreen({Key? key, required this.videoBot})
//       : super(key: key);
//
//   @override
//   State<UpdateQuestionScreen> createState() => _UpdateQuestionScreenState();
// }
//
// class _UpdateQuestionScreenState extends State<UpdateQuestionScreen> {
//   @override
//   void initState() {
//     clearVideoModuleLists();
//     super.initState();
//   }
//
//   bool disable = false;
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
//           UpdateQuestionCard(disable: disable, videoBot: widget.videoBot),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
