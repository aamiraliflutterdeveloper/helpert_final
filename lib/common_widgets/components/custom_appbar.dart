import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/nav_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool hasElevation;
  final bool automaticallyImplyLeading;
  final double fontSize;
  final VoidCallback? onBackIconPress;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.hasElevation = false,
    this.fontSize = 18,
    this.automaticallyImplyLeading = true,
    this.onBackIconPress,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.black),
      elevation: hasElevation ? .5 : 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      leading: (automaticallyImplyLeading)
          ? Padding(
              padding: EdgeInsets.only(top: hasElevation ? 12.0 : 0),
              child: IconButton(
                splashRadius: 24,
                onPressed: onBackIconPress ??
                    () {
                      NavRouter.pop(context);
                    },
                icon: const SvgImage(
                  path: ic_backbutton,
                ),
              ),
            )
          : null,
      title: Padding(
        padding: EdgeInsets.only(top: hasElevation ? 12.0 : 0),
        child: Text(
          title,
          style: TextStyles.boldTextStyle(
              fontSize: fontSize, textColor: AppColors.black),
        ),
      ),
    );
  }
}
