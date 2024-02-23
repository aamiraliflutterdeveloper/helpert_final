import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';

class ChatBottomWidget extends StatelessWidget {
  final VoidCallback onPrefixIconTap;
  final VoidCallback pickImageCallback;
  final VoidCallback onTapSendButton;
  final Function(String) onChanged;
  final TextEditingController controller;

  const ChatBottomWidget(
      {Key? key,
      required this.onPrefixIconTap,
      required this.pickImageCallback,
      required this.onTapSendButton,
      required this.onChanged,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        boxShadow: const [
          BoxShadow(
            color: AppColors.snow,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Material(
              color: AppColors.snow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // IconButton(
                  //   splashRadius: 24,
                  //   padding: EdgeInsets.zero,
                  //   icon: Icon(
                  //     Icons.emoji_emotions,
                  //     color: AppColors.moon,
                  //   ),
                  //   onPressed: onPrefixIconTap,
                  // ),
                  SizedBox(width: 14),
                  Expanded(
                    child: TextField(
                      cursorColor: AppColors.acmeBlue,
                      onChanged: onChanged,
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your message...',
                        hintStyle: TextStyles.regularTextStyle(
                            fontSize: 14, textColor: AppColors.nickel),
                      ),
                    ),
                  ),
                  IconButton(
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.camera_alt,
                      color: AppColors.moon,
                    ),
                    onPressed: pickImageCallback,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          SizedBox(
            width: 44,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.acmeBlue,
                  padding: EdgeInsets.zero),
              onPressed: onTapSendButton,
              child: Icon(
                Icons.send,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
