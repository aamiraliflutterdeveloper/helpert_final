// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/constants/text_styles.dart';
// import 'package:helpert_app/core/data/video_data.dart';
//
// import '../../../../reusable_video_list/reusable_video_list_controller.dart';
// import 'video_slider_widget.dart';
//
// class CarouselSliderPage extends StatefulWidget {
//   const CarouselSliderPage({Key? key}) : super(key: key);
//
//   @override
//   _CarouselSliderPageState createState() => _CarouselSliderPageState();
// }
//
// class _CarouselSliderPageState extends State<CarouselSliderPage> {
//   late PageController _pageController;
//   ReusableVideoListController videoListController =
//       ReusableVideoListController();
//   @override
//   void initState() {
//     super.initState();
//     _setData();
//     _pageController = PageController(initialPage: 0, viewportFraction: .88);
//   }
//
//   bool _canBuildVideo = true;
//   @override
//   void dispose() {
//     super.dispose();
//     _pageController.dispose();
//   }
//
//   int currentIndex = 0;
//   List<int> filledColorContainers = [0];
//
//   _setData() {}
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF171923),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         // color: Color(0xFF151721),
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0) +
//                   const EdgeInsets.only(top: 24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text('Close',
//                       style: TextStyles.regularTextStyle(
//                           textColor: AppColors.moon)),
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
//                   Text('Publish',
//                       style: TextStyles.regularTextStyle(
//                           textColor: AppColors.moon)),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: PageView.builder(
//                 itemCount: 6,
//                 controller: _pageController,
//                 itemBuilder: (context, index) {
//                   return VideoSliderWidget(
//                     index: index,
//                     videoListData: VideoModule.dataList,
//                     videoListController: videoListController,
//                     canBuildVideo: _checkCanBuildVideo,
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool _checkCanBuildVideo() {
//     return _canBuildVideo;
//   }
// }
