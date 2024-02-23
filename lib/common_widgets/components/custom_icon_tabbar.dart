import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helpert_app/common_widgets/components/tabbar_decoration.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class CustomIconTabBar extends StatelessWidget {
  const CustomIconTabBar({
    Key? key,
    required TabController controller,
    required this.tabs,
    required this.onTap,
    required this.icon,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;
  final List<String> tabs;
  final Function(int) onTap;
  final List<String> icon;

  @override
  Widget build(BuildContext context) {
    return TabBarDecoration(
      tabBar: TabBar(
        indicatorWeight: 6,
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon[index],
                    color: _controller.index == index
                        ? AppColors.acmeBlue
                        : AppColors.moon),
                const SizedBox(width: 6),
                Text(tabs[index])
              ],
            ),
          ),
        ),
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.silver, width: 5)),
      ),
    );
  }
}
