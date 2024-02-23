// import 'package:flutter/material.dart';
// import 'package:helpert_app/core/data/video_data.dart';
// import 'package:helpert_app/dashboard_screen.dart';
// import 'package:helpert_app/features/reusable_video_list/app_data.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../../constants/app_colors.dart';
// import '../../constants/text_styles.dart';
// import '../video/model/carousel_model.dart';
// import 'reusable_video_list_controller.dart';
// import 'reusable_video_list_widget.dart';
//
// class ReusableVideoListPage extends StatefulWidget {
//   @override
//   _ReusableVideoListPageState createState() => _ReusableVideoListPageState();
// }
//
// class _ReusableVideoListPageState extends State<ReusableVideoListPage> {
//   ReusableVideoListController videoListController =
//       ReusableVideoListController();
//   final List<String> _videos = Appdata.videoList;
//   List<VideoListData> dataList = [];
//   var value = 0;
//   final PageController _scrollController =
//       PageController(initialPage: 0, viewportFraction: .9);
//   int lastMilli = DateTime.now().millisecondsSinceEpoch;
//   bool _canBuildVideo = true;
//
//   @override
//   void initState() {
//     _setupData();
//     super.initState();
//   }
//
//   void _setupData() {
//     for (int index = 0; index < _videos.length; index++) {
//       dataList.add(VideoListData("Video $index", _videos[index]));
//     }
//   }
//
//   @override
//   void dispose() {
//     videoListController.dispose();
//     super.dispose();
//   }
//
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black.withOpacity(.3),
//       body: SafeArea(
//         child: Container(
//           alignment: Alignment.center,
//           color: Colors.black.withOpacity(.3),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0) +
//                   EdgeInsets.only(top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Close',
//                         style: TextStyles.regularTextStyle(
//                             textColor: AppColors.moon)),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     child: Row(
//                       children: List.generate(6, (index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(left: 15.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: currentIndex == index
//                                     ? AppColors.pureWhite
//                                     : AppColors.greyText,
//                                 borderRadius: BorderRadius.circular(30)),
//                             height: 7,
//                             width: 7,
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                   GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () {
//                       if (VideoModule.questionPublish.isNotEmpty) {
//                         NavRouter.pushReplacement(context, DashBoardScreen());
//                       }
//                     },
//                     child: Text('Publish',
//                         style: TextStyles.regularTextStyle(
//                             textColor: VideoModule.questionPublish.isNotEmpty
//                                 ? AppColors.acmeBlue
//                                 : AppColors.moon)),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: NotificationListener<ScrollNotification>(
//                 child: PageView.builder(
//                   onPageChanged: (val) {
//                     currentIndex = val;
//                     setState(() {});
//                   },
//                   itemCount: dataList.length,
//                   controller: _scrollController,
//                   itemBuilder: (context, index) {
//                     VideoListData videoListData = dataList[index];
//                     bool active = index == currentIndex;
//                     return ReusableVideoListWidget(
//                       active: active,
//                       videoListData: videoListData,
//                       videoListController: videoListController,
//                       canBuildVideo: _checkCanBuildVideo,
//                       index: index,
//                     );
//                   },
//                 ),
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
//
//   bool _checkCanBuildVideo() {
//     return _canBuildVideo;
//   }
// }
