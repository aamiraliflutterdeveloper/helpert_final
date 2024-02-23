import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/auth/models/user_model.dart';

class TabsRowWidget extends StatelessWidget {
  final int selectedIndex;
  final List<ListItem> tabs;
  final Function(int) onTap;
  const TabsRowWidget(
      {Key? key,
      required this.tabs,
      required this.onTap,
      required this.selectedIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onTap(-1),
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: 16,
            ),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.silver),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'All',
              style: TextStyles.regularTextStyle(
                  fontSize: 14,
                  textColor: selectedIndex == -1
                      ? AppColors.acmeBlue
                      : AppColors.moon),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              tabs.length,
              (index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(index),
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: index != 0 ? 16 : 0,
                        right: index != tabs.lastIndexOf(tabs[index]) ? 16 : 0,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.silver),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        tabs[index].name,
                        style: TextStyles.regularTextStyle(
                            fontSize: 14,
                            textColor: selectedIndex == index
                                ? AppColors.acmeBlue
                                : AppColors.moon),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
