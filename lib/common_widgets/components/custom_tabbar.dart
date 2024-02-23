import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

import 'tabbar_decoration.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required TabController controller,
    required this.tabs,
    required this.onTap,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;
  final List<String> tabs;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return TabBarDecoration(
      tabBar: TabBar(
        indicatorWeight: 2,
        indicatorColor: AppColors.acmeBlue,
        labelStyle: TextStyles.boldTextStyle(
            fontSize: 14.0, textColor: AppColors.black),
        labelColor: AppColors.black, //For Selected tab
        unselectedLabelStyle: TextStyles.mediumTextStyle(
            fontSize: 14.0, textColor: AppColors.moon),
        unselectedLabelColor: AppColors.moon,
        controller: _controller,
        onTap: onTap,
        tabs: List.generate(
          tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              tabs[index],
            ),
          ),
        ),
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.silver,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
