import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/chat/model/recent_chat_model.dart';
import 'package:helpert_app/features/chat/screens/chat_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:helpert_app/utils/scroll_behavior.dart';

import '../../../common_widgets/components/custom_appbar.dart';
import '../cubit/recent_chat_cubit.dart';
import '../widgets/recent_message_tile.dart';

class RecentChatScreen extends StatefulWidget {
  const RecentChatScreen({Key? key}) : super(key: key);

  @override
  State<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends State<RecentChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecentChatCubit>().listenRecentChats();
    context.read<RecentChatCubit>().emitRecentChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Messages',
        automaticallyImplyLeading: false,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: BlocConsumer<RecentChatCubit, RecentChatState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is RecentChatLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.recentChatList.length,
                itemBuilder: (BuildContext context, int index) {
                  final RecentChatModel model = state.recentChatList[index];
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        NavRouter.push(
                          context,
                          ChatScreen(
                            name:
                                '${model.user.firstName} ${model.user.lastName}',
                            image: model.user.image,
                            receiverId: model.user.id,
                            speciality: model.user.specialization,
                            timezone: model.user.timezone,
                            sessionRate: model.user.sessionRate,
                          ),
                        ).then((value) {
                          context.read<RecentChatCubit>().emitRecentChats();
                          context.read<RecentChatCubit>().listenRecentChats();
                        });
                      },
                      child: RecentMessageTile(model: model));
                },
              );
            } else if (state is NoRecentChatFound) {
              return Center(child: Text('No conversation found!'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
