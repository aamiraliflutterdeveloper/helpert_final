import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/loader.dart';
import 'package:helpert_app/common_widgets/show_data_widget.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/chat/cubit/video_call_cubit.dart';
import 'package:helpert_app/features/chat/widgets/chat_appbar.dart';
import 'package:helpert_app/features/chat/widgets/chat_bottom_widget.dart';
import 'package:helpert_app/features/chat/widgets/receiver_tile.dart';
import 'package:helpert_app/features/video/bloc/notification_count/notification_count_bloc.dart';

import '../../../common_widgets/image_picker_manager.dart';
import '../../../core/services/socket_service.dart';
import '../../../utils/nav_router.dart';
import '../../../utils/ui_utils/custom_bottom_sheet.dart';
import '../../other_user_profile/screens/other_profile_screen.dart';
import '../../video/bloc/notification_count/message_count_bloc.dart';
import '../cubit/chat_cubit.dart';
import '../model/chat_model.dart';
import '../widgets/sender_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.receiverId,
    required this.speciality,
    required this.timezone,
    required this.sessionRate,
  }) : super(key: key);
  final String name;
  final String? image;
  final int receiverId;
  final int sessionRate;
  final String speciality;
  final String timezone;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  File? _pickedImage;

  void _pickImage() async {
    String result = await CustomBottomSheet.imageSelectionBottomSheet(context);
    if (result == 'camera') {
      _pickedImage = await ImagePickerManager.getImageFromCamera(context,
          hasCroppedFunctionality: false);
      setState(() {});
      if (_pickedImage != null) {
        context.read<ChatCubit>().emitAttachment(
              AuthRepo.instance.user.userId,
              widget.receiverId,
              _pickedImage!,
            );
      }
    } else if (result == 'gallery') {
      _pickedImage = await ImagePickerManager.getImageFromGallery(context,
          hasCroppedFunctionality: false);
      setState(() {});
      if (_pickedImage != null) {
        context.read<ChatCubit>().emitAttachment(
              AuthRepo.instance.user.userId,
              widget.receiverId,
              _pickedImage!,
            );
      }
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // chat history
    // context.read<ChatCubit>().timeOverFunction();
    context.read<VideoCallCubit>().getUserAppointment(widget.receiverId);
    context
        .read<ChatCubit>()
        .emitChatHistory(AuthRepo.instance.user.userId, widget.receiverId);
    context.read<ChatCubit>().listenAndLoadChatHistory(
        AuthRepo.instance.user.userId, widget.receiverId);
    // chat messages
    context.read<ChatCubit>().listenToMessages();
  }

  @override
  void dispose() {
    SocketService.instance.socket.off(
        '${AuthRepo.instance.user.userId}-${widget.receiverId}-${SocketListeners.CHAT_HISTORY_LISTENER}');
    SocketService.instance.socket.off(
        '${AuthRepo.instance.user.userId}${SocketListeners.RECEIVE_MESSAGE_LISTENER}');
    super.dispose();
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    }
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: ChatAppbar(
        tapOnProfile: () {
          NavRouter.push(
              context, OtherUserProfileScreen(userId: widget.receiverId));
        },
        id: widget.receiverId,
        image: widget.image,
        name: widget.name,
        specialization: widget.speciality,
        timezone: widget.timezone,
        sessionRate: widget.sessionRate,
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatLoaded) {
                    _pickedImage = null;
                  }
                },
                builder: (context, state) {
                  if (state is ChatLoaded) {
                    Future.delayed(Duration(seconds: 0)).then((value) {
                      scrollToBottom();
                    });
                    return ListView.builder(
                        controller: _scrollController,
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        itemCount: state.chatList.length,
                        itemBuilder: (context, index) {
                          Chat chat = state.chatList[index];
                          bool isMe =
                              AuthRepo.instance.user.userId == chat.senderId;
                          //
                          return isMe
                              ? SenderTile(
                                  chat: chat,
                                  pickedImage: _pickedImage,
                                )
                              : ReceiverTile(
                                  chat: chat,
                                  pickedImage: _pickedImage,
                                );
                        });
                  } else if (state is NoChatFound) {
                    return ShowDataWidget('No chat found');
                  }
                  return Loader();
                },
              ),
            ),
            ChatBottomWidget(
              onTapSendButton: () {
                // send msg
                if (textEditingController.text.isNotEmpty) {
                  String msg = textEditingController.text;
                  textEditingController.clear();
                  context.read<ChatCubit>().emitMessage(
                        AuthRepo.instance.user.userId,
                        widget.receiverId,
                        msg,
                      );
                  MessageCountBloc.get(context).emitMessageCount(
                    receiverId: widget.receiverId,
                  );
                  NotificationCountBloc.get(context).emitNotificationCount(
                    receiverId: widget.receiverId,
                  );
                }
              },
              pickImageCallback: () {
                _pickImage();
              },
              onPrefixIconTap: () {},
              onChanged: (value) {},
              controller: textEditingController,
            ),
          ],
        ),
      ),
    );
  }
}
