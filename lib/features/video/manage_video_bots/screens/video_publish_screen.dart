// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
// import 'package:helpert_app/constants/text_styles.dart';
// import 'package:helpert_app/utils/nav_router.dart';
//
// import '../../../../common_widgets/bottons/custom_elevated_button.dart';
// import '../../../../common_widgets/cancel_publisher_topbar.dart';
// import '../../../../common_widgets/textfield/custom_textformfield.dart';
// import 'congratulation_screen.dart';
// import 'new_add_video_bot/slider_video_player/idle_video_module/idle_video_camera_screen.dart';
//
// class VideoPublishScreen extends StatefulWidget {
//   const VideoPublishScreen({Key? key}) : super(key: key);
//
//   @override
//   State<VideoPublishScreen> createState() => _VideoPublishScreenState();
// }
//
// class _VideoPublishScreenState extends State<VideoPublishScreen> {
//   final questionController = TextEditingController();
//
//   @override
//   void initState() {
//     questionController.text = 'How Physiotherapist get paid?';
//     super.initState();
//   }
//
//   bool disable = false;
//
//   int count = 0;
//   List<int> indexes = [0];
//   List<String> answers = [];
//   List questions = [];
//   final _formKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   void _add() {
//     setState(() {
//       count++;
//       indexes.add(count);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           CancelPublishTopBar(),
//           Expanded(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 20,
//                       spreadRadius: 4,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 20),
//                       Expanded(
//                         child: ListView(
//                           padding: EdgeInsets.zero,
//                           physics: const ClampingScrollPhysics(),
//                           children: [
//                             Text(
//                               "What are commonly / frequently asked questions to you, by your followers",
//                               textAlign: TextAlign.center,
//                               style: TextStyles.boldTextStyle(),
//                             ),
//                             SizedBox(height: 25),
//                             Form(
//                               key: _formKey,
//                               child: ListView(
//                                 padding: EdgeInsets.zero,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 children: List.generate(
//                                   indexes.length,
//                                   (index) => CustomTextFormField(
//                                       onSaved: (value) {
//                                         answers.add(value!);
//                                       },
//                                       readOnly: true,
//                                       onTap: () {},
//                                       keyboardType: TextInputType.text,
//                                       labelText: 'Add question',
//                                       onChanged: (val) {}),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: CustomElevatedButton(
//                           disable: disable,
//                           title: 'Add another question',
//                           onTap: () {
//                             _add();
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         child: CustomElevatedButton(
//                           disable: disable,
//                           title: 'Publish',
//                           onTap: () {
//                             NavRouter.push(context, CongratulationScreen());
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       IconButton(
//                           splashRadius: 50,
//                           hoverColor: AppColors.silver,
//                           onPressed: () {
//                             NavRouter.push(context, IdleVideoCameraScreen());
//                             if (!_formKey.currentState!.validate()) {
//                               return;
//                             }
//                             _formKey.currentState!.save();
//                           },
//                           icon: Icon(Icons.videocam, size: 40)),
//                       SizedBox(height: 15),
//                       Text("Tap to record answer",
//                           style: TextStyles.regularTextStyle()),
//                       SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
