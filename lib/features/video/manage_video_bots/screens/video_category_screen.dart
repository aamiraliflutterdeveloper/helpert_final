import 'package:flutter/material.dart';
import 'package:helpert_app/core/data/video_data.dart';
import 'package:helpert_app/features/reusable_video_list/app_data.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../common_widgets/cancel_publisher_topbar.dart';
import '../widgets/category_card.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  bool disable = false;

  @override
  initState() {
    Future.delayed(Duration.zero, () {
      // context.read<VideoBloc>().fetchAllInterest();
    });
    Appdata.isFromSlider = false;
    VideoModule.interestID.clear();
    clearVideoModuleLists();
    Appdata.videoList = ['', '', '', '', '', ''];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 40),
          CancelPublishTopBar(
            onTap: () {
              NavRouter.pop(context);
            },
          ),
          CategoryCard(disable: disable),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
