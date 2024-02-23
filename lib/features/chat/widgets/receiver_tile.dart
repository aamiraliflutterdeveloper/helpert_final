import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/text_styles.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/date_formatter.dart';
import '../model/chat_model.dart';

class ReceiverTile extends StatelessWidget {
  const ReceiverTile({Key? key, required this.chat, this.pickedImage})
      : super(key: key);
  final Chat chat;
  final File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        chat.attachment == null
            ? Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.all(16),
                child: Text(
                  chat.message,
                  style: TextStyles.regularTextStyle(
                      fontSize: 14.5, textColor: Color(0xFF333333)),
                ),
                decoration: BoxDecoration(
                  color: AppColors.snow,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: true,
                      barrierDismissible: false,
                      fullscreenDialog: true,
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
                      color: AppColors.snow,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
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
          padding: const EdgeInsets.only(top: 6.0, left: 12),
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
