// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:helpert_app/core/data/video_data.dart';
// import 'package:helpert_app/features/video/bloc/video/video_bloc.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../../../../common_widgets/cancel_publisher_topbar.dart';
// import '../../../video/model/videos_model.dart';
// import '../widgets/update_category_card.dart';
//
// class UpdateVideoCategoryScreen extends StatefulWidget {
//   final VideoBotModel videoBot;
//   const UpdateVideoCategoryScreen({Key? key, required this.videoBot})
//       : super(key: key);
//
//   @override
//   State<UpdateVideoCategoryScreen> createState() =>
//       _UpdateVideoCategoryScreenState();
// }
//
// class _UpdateVideoCategoryScreenState extends State<UpdateVideoCategoryScreen> {
//   bool disable = false;
//
//   @override
//   initState() {
//     Future.delayed(Duration.zero, () {
//       VideoModule.categoryList.clear();
//       context.read<VideoBloc>().fetchAllInterest();
//     });
//     VideoModule.interestID.clear();
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
//           UpdateCategoryCard(disable: disable, videoBot: widget.videoBot),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
