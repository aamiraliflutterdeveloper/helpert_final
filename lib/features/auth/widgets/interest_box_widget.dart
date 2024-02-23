import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/features/auth/models/user_model.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/consts.dart';

class InterestsBoxWidget extends StatelessWidget {
  final ListItem title;
  final List<int> storesItems;
  final Function(int) onTap;
  const InterestsBoxWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.storesItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(title.id),
      child: Container(
        decoration: BoxDecoration(
            color: storesItems.contains(title.id)
                ? AppColors.acmeBlue
                : AppColors.pureWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: storesItems.contains(title.id)
                  ? AppColors.acmeBlue
                  : AppColors.black,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 6, 10, 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: VIDEO_BASE_URL + title.icon,
                width: 16,
                height: 16,
              ),
              SizedBox(
                width: 6,
              ),
              Text(title.name,
                  style: TextStyle(
                      color: storesItems.contains(title.id)
                          ? AppColors.pureWhite
                          : AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: poppinsFamily)),
            ],
          ),
        ),
      ),
    );
  }
}
