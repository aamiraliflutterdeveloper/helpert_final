import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/chat/model/chat_model.dart';
import 'package:helpert_app/utils/date_formatter.dart';

import '../../../constants/app_colors.dart';

class SenderTile extends StatelessWidget {
  const SenderTile({Key? key, required this.chat, this.pickedImage})
      : super(key: key);
  final Chat chat;
  final File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        chat.attachment == null
            ? Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.all(16),
                child: Text(
                  chat.message,
                  style: TextStyles.regularTextStyle(
                      fontSize: 14.5, textColor: AppColors.pureWhite),
                ),
                decoration: BoxDecoration(
                  color: AppColors.acmeBlue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: true,
                      barrierDismissible: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return Scaffold(
                          body: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: const Icon(Icons.cancel_sharp)),
                                ),
                                Expanded(
                                  child: InteractiveViewer(
                                    scaleEnabled: true,
                                    panEnabled: true,
                                    child: Hero(
                                      tag: chat.attachment,
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '$VIDEO_BASE_URL${chat.attachment}',
                                          placeholder: (context, url) =>
                                              const CupertinoActivityIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: chat.attachment,
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 12),
                    padding: EdgeInsets.all(16),
                    // child:
                    //     // pickedImage != null
                    //     //     ? Image.file(pickedImage!)
                    //     //     :
                    //     CachedNetworkImage(
                    //         imageUrl: '${VIDEO_BASE_URL}${chat.attachment}'),
                    decoration: BoxDecoration(
                      color: AppColors.acmeBlue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                          '$VIDEO_BASE_URL${chat.attachment}',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 12),
          child: Text(
            DateFormatter.amPmTime(chat.createdAt),
            style: TextStyles.mediumTextStyle(
                fontSize: 10, textColor: AppColors.moon),
          ),
        ),
      ],
    );
  }
}
