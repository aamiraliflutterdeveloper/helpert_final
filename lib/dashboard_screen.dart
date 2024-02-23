import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/utils/nav_router.dart';

import 'common_widgets/components/custom_bottom_appbar.dart';
import 'core/services/socket_service.dart';
import 'features/appointment/screens/appointments_screen.dart';
import 'features/chat/screens/recent_chat_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/video/bloc/notification_count/appointment_count_bloc.dart';
import 'features/video/bloc/notification_count/message_count_bloc.dart';
import 'features/video/bloc/notification_count/notification_count_bloc.dart';
import 'features/video_call/bloc/home/home_cubit.dart';
import 'features/video_call/bloc/home/home_state.dart';
import 'features/video_call/screens/call_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedIndex = 0;
  bool wantToChangeState = false;

  Widget getCurrentScreen(int index) {
    Widget widget = Container();
    switch (index) {
      case 0:
        widget = const HomeScreen();
        break;
      case 1:
        widget = const AppointmentsScreen();
        break;
      case 3:
        widget = const RecentChatScreen();
        break;
      case 4:
        widget = ProfileScreen(
          wantToChangeState: wantToChangeState,
        );
        break;
    }

    return widget;
  }

  void changeIndex(int index) {
    // if user is tapping on same item
    if (selectedIndex == index) {
      return;
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    initSocket();
    HomeCubit.get(context).listenToStartCall();
    NotificationCountBloc.get(context).listenToNotificationCount();
    AppointmentCountBloc.get(context).listenToAppointmentCount();
    MessageCountBloc.get(context).listenToMessageCount();
    NotificationCountBloc.get(context).emitNotificationCount();
    AppointmentCountBloc.get(context).emitAppointmentCount();
    MessageCountBloc.get(context).emitMessageCount();
  }

  initSocket() async {
    await SocketService.instance.init();
  }

  @override
  void dispose() {
    SocketService.instance.socket
        .off('${AuthRepo.instance.user.userId}${SocketListeners.START_CALL}');
    SocketService.instance.socket.off(SocketListeners.GET_NOTIFICATIONS);
    SocketService.instance.socket.off(SocketListeners.GET_APPOINTMENT_COUNT);
    SocketService.instance.socket.off(SocketListeners.GET_MESSAGE_COUNT);
    SocketService.instance.socket.clearListeners();
    SocketService.instance.socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      extendBody: true,
      bottomNavigationBar: CustomBottomAppbar(
        currentIndex: selectedIndex,
        onChanged: (int index) {
          if (index == 1) {
            context.read<AppointmentCountBloc>().updateNotificationCountApi();
            setState(() {
              selectedIndex = index;
            });
          } else if (index == 2) {
            wantToChangeState = true;
          } else if (index == 3) {
            context.read<MessageCountBloc>().updateMessageCountApi();
            setState(() {
              selectedIndex = index;
            });
          } else {
            setState(() {
              selectedIndex = index;
            });
          }
        },
      ),
      body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
        //FireCall States
        if (state is ErrorFireVideoCallState) {
          NavRouter.pop(context);
          BotToast.showText(text: state.message);
        }
        if (state is SuccessFireVideoCallState) {
          NavRouter.push(context,
              CallScreen(isReceiver: false, callModel: state.callModel));
        }

        //Receiver Call States
        if (state is SuccessInComingCallState) {
          NavRouter.push(context,
              CallScreen(isReceiver: true, callModel: state.callModel));
        }
      }, builder: (context, state) {
        return getCurrentScreen(selectedIndex);
      }),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.acmeBlue,
      //   onPressed: () {
      //     wantToChangeState = true;
      //     NavRouter.push(context, ManageVideoBotsScreen()).then((value) {
      //       // context.read<ProfileBloc>().profileFetched = false;
      //
      //       // context.read<ProfileBloc>().fetchProfile();
      //       setState(() {});
      //     });
      //   },
      //   child: const SvgImage(
      //     path: ic_plus,
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
