import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/constants/app_colors.dart';

class UserInfoHeader extends StatelessWidget {
  final String avatar;
  final String name;

  const UserInfoHeader({
    Key? key,
    required this.avatar,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.0,
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: avatar.isNotEmpty
                ? CircleAvatar(
                    backgroundColor: AppColors.acmeBlue,
                    radius: 25.0,
                    backgroundImage: CachedNetworkImageProvider(
                      '$VIDEO_BASE_URL$avatar',
                    ),
                  )
                : const Icon(Icons.person),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
