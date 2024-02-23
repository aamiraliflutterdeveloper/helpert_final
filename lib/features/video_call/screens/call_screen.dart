import 'dart:async';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/consts.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/video_call/screens/review_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/asset_paths.dart';
import '../../../core/services/socket_service.dart';
import '../../auth/repo/auth_repo.dart';
import '../bloc/call/call_cubit.dart';
import '../bloc/call/call_state.dart';
import '../model/call_model.dart';
import '../widget/default_circle_image.dart';
import '../widget/user_info_header.dart';

class CallScreen extends StatefulWidget {
  final bool isReceiver;
  final CallModel callModel;
  const CallScreen(
      {Key? key, required this.isReceiver, required this.callModel})
      : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with TickerProviderStateMixin {
  late CallCubit _callCubit;
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();

    _callCubit = CallCubit.get(context);
    _callCubit.timeOverFunction();

    _callCubit.remoteUid = null;
    rePermission();
    _callCubit.listenToStatusCall(context);
    if (!widget.isReceiver) {
      //Caller
      _callCubit.initAgoraAndJoinChannel(
          uId: widget.callModel.callerId!,
          channelToken: widget.callModel.token!,
          channelName: widget.callModel.channelName!,
          isCaller: true,
          context: context,
          callModel: widget.callModel);
    } else {
      //Receiver
      _callCubit.playContactingRing(isCaller: false);
    }
  }

  bool running = false;

  @override
  void dispose() {
    _callCubit.remoteUid = null;
    if (_callCubit.engine != null) {
      if (_controller != null) {
        _controller!.dispose();
      }
      _callCubit.engine!.destroy();
    }
    // _callCubit.assetsAudioPlayer.dispose();
    FlutterRingtonePlayer.stop();
    if (!widget.isReceiver) {
      //Sender
      _callCubit.countDownTimer.cancel();
    }
    _callCubit.emitStatusCall(
        callModel: widget.callModel,
        status: CallStatus.end,
        current: 0,
        context: context);
    SocketService.instance.socket
        .off('${AuthRepo.instance.user.userId}${SocketListeners.STATUS_CALL}');
    super.dispose();
  }

  Future<void> rePermission() async {
    await [Permission.microphone, Permission.camera].request();
  }

  @override
  Widget build(BuildContext context) {
    // if (_callCubit.remoteUid != null && !running) {
    //   running = true;
    //   _startTime();
    // }
    return BlocConsumer<CallCubit, CallState>(
      listener: (BuildContext context, Object? state) async {
        if (state is ErrorUnAnsweredVideoChatState) {
          BotToast.showText(text: 'UnExpected Error!: ${state.error}');
        }
        if (state is DownCountCallTimerFinishState) {
          if (_callCubit.remoteUid == null) {
            _callCubit.emitStatusCall(
                callModel: widget.callModel,
                status: CallStatus.unAnswer,
                current: 0,
                context: context);
          }
        }

        if (state is AgoraRemoteUserJoinedEvent) {
          //remote user join channel
          _controller = AnimationController(
              vsync: this,
              duration: Duration(
                  seconds:
                      1800) // gameData.levelClock is a user entered number elsewhere in the applciation
              );
          _controller!.forward();
          if (!widget.isReceiver) {
            _callCubit.countDownTimer.cancel();
          }
          FlutterRingtonePlayer.stop();
        }

        //Call States
        if (state is CallNoAnswerState) {
          if (!widget.isReceiver) {
            //Caller

            BotToast.showText(text: 'No response!');
          }
          Navigator.pop(context);
        }

        if (state is CallCancelState) {
          if (widget.isReceiver) {
            //Receiver
            BotToast.showText(text: 'Caller cancel the call!');
          }
          Navigator.pop(context);
        }
        if (state is CallRejectState) {
          if (!widget.isReceiver) {
            //Caller
            BotToast.showText(text: 'Receiver reject the call!');
          }
          Navigator.pop(context);
        }
        if (state is CallEndState) {
          BotToast.showText(text: 'Call ended!');
          bool result = await _callCubit.checkRatingRating(
              widget.callModel.doctorId!, widget.callModel.bookingId!);
          if (widget.callModel.userId == AuthRepo.instance.user.userId &&
              !result) {
            NavRouter.pushReplacement(
                context,
                ReviewScreen(
                    doctorId: widget.callModel.doctorId!,
                    bookingId: widget.callModel.bookingId!,
                    doctorImage:
                        widget.callModel.callerId == widget.callModel.userId
                            ? widget.callModel.receiverAvatar!
                            : widget.callModel.callerAvatar!,
                    doctorName: widget.callModel.callerId ==
                            AuthRepo.instance.user.userId
                        ? widget.callModel.receiverName!
                        : widget.callModel.callerName!));
          } else {
            NavRouter.pop(context);
          }
        }
      },
      builder: (BuildContext context, state) {
        var cubit = CallCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                cubit.remoteUid == null
                    ? !widget.isReceiver
                        ? Container(
                            color: Colors.black,
                            child: RtcLocalView.SurfaceView())
                        : Container(
                            decoration: widget.callModel.callerAvatar != null &&
                                    widget.callModel.callerAvatar!.isNotEmpty
                                ? BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        VIDEO_BASE_URL +
                                            widget.callModel.callerAvatar!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/png/no_profile.png',
                                      ),
                                    ),
                                  ),
                          )
                    : Stack(
                        children: [
                          Center(
                            child: _remoteVideo(remoteUserId: cubit.remoteUid!),
                          ),
                          Positioned(
                            top: 30,
                            right: 30,
                            child: SafeArea(
                              child: SizedBox(
                                width: 120,
                                height: 180.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: RtcLocalView.SurfaceView(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    !widget.isReceiver
                        ? UserInfoHeader(
                            //Caller -> Show Receiver INFO
                            avatar: widget.callModel.receiverAvatar!,
                            name: widget.callModel.receiverName!,
                          )
                        : UserInfoHeader(
                            //Receiver -> Show Caller INFO
                            avatar: widget.callModel.callerAvatar!,
                            name: widget.callModel.callerName!,
                          ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    cubit.remoteUid == null
                        ? Expanded(
                            child: widget.isReceiver
                                ? Text(
                                    '${widget.callModel.callerName} is calling you..',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 39.0),
                                  )
                                : const Text(
                                    'Contacting..',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 39.0),
                                  ),
                          )
                        : Expanded(child: Container()),
                    cubit.remoteUid == null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.isReceiver
                                    ? Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            //receiverAcceptVideoChat
                                            _callCubit.emitStatusCall(
                                                callModel: widget.callModel,
                                                status: CallStatus.accept,
                                                current: 1,
                                                context: context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: Colors.green,
                                            ),
                                            child: const Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30.0,
                                                    vertical: 8.0),
                                                child: Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                widget.isReceiver
                                    ? const SizedBox(
                                        width: 15.0,
                                      )
                                    : Container(),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if (widget.isReceiver) {
                                        //receiverRejectVideoChat
                                        _callCubit.emitStatusCall(
                                            callModel: widget.callModel,
                                            status: CallStatus.reject,
                                            current: 0,
                                            context: context);
                                      } else {
                                        //callerCancelVideoChat
                                        _callCubit.emitStatusCall(
                                            callModel: widget.callModel,
                                            status: CallStatus.cancel,
                                            current: 0,
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0, vertical: 8.0),
                                          child: Text(
                                            widget.isReceiver
                                                ? 'Reject'
                                                : 'Cancel',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(.2),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    !widget.isReceiver
                                        ? Text(
                                            widget.callModel.receiverName ?? '',
                                            style: TextStyles.boldTextStyle(
                                                textColor: AppColors.pureWhite,
                                                fontSize: 28),
                                          )
                                        : Text(
                                            widget.callModel.callerName ?? '',
                                            style: TextStyles.boldTextStyle(
                                                textColor: AppColors.pureWhite,
                                                fontSize: 28),
                                          ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    !widget.isReceiver
                                        ? Text(
                                            widget.callModel
                                                    .receiverSpecialization ??
                                                '',
                                            style: TextStyles.regularTextStyle(
                                                textColor: AppColors.pureWhite,
                                                fontSize: 14),
                                          )
                                        : Text(
                                            widget.callModel
                                                    .callerSpecialization ??
                                                '',
                                            style: TextStyles.regularTextStyle(
                                                textColor: AppColors.pureWhite,
                                                fontSize: 14),
                                          ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    if (_controller != null)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: AppColors.moon.withOpacity(.4),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Countdown(
                                          animation: StepTween(
                                            begin:
                                                0, // THIS IS A USER ENTERED NUMBER
                                            end: 1800,
                                          ).animate(_controller!),
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: Container()),
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            _callCubit.emitStatusCall(
                                                callModel: widget.callModel,
                                                status: CallStatus.end,
                                                current: 0,
                                                context: context);
                                          },
                                          child: const DefaultCircleImage(
                                            bgColor: Color(0xFFFC015B),
                                            image: Icon(
                                              Icons.call_end_rounded,
                                              color: Colors.white,
                                              size: 34,
                                            ),
                                            center: true,
                                            width: 80,
                                            height: 80,
                                          )),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.switchCamera();
                                        },
                                        child: DefaultCircleImage(
                                          bgColor: Colors.white,
                                          image: SvgImage(path: icCameraSwitch),
                                          center: true,
                                          width: 42,
                                          height: 42,
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       cubit.toggleMuted();
                                    //     },
                                    //     child: DefaultCircleImage(
                                    //       bgColor: Colors.white,
                                    //       image: cubit.muteIcon,
                                    //       center: true,
                                    //       width: 42,
                                    //       height: 42,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Your call is secure',
                                    textAlign: TextAlign.center,
                                    style: TextStyles.regularTextStyle(
                                        textColor: AppColors.pureWhite,
                                        fontSize: 13.15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Display remote user's video
  Widget _remoteVideo({required int remoteUserId}) {
    return RtcRemoteView.SurfaceView(
      uid: remoteUserId,
      channelId: widget.callModel.channelName!,
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inHours == 0 ? '00' : clockTimer.inHours.remainder(60).toString()}:${clockTimer.inMinutes == 0 ? '00' : clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.pureWhite,
      ),
    );
  }
}
