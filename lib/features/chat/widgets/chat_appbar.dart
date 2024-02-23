import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/features/appointment/screens/appointment_detail_screen.dart';
import 'package:helpert_app/features/book_call/screens/booking_slot_screen.dart';
import 'package:helpert_app/features/chat/cubit/video_call_cubit.dart';
import 'package:helpert_app/features/chat/cubit/video_call_state.dart';
import 'package:helpert_app/features/reusable_video_list/app_data.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../common_widgets/custom_dialog.dart';
import '../../../common_widgets/fetch_svg.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/asset_paths.dart';
import '../../../constants/consts.dart';
import '../../../constants/text_styles.dart';
import '../../auth/repo/auth_repo.dart';
import '../../video_call/bloc/home/home_cubit.dart';
import '../../video_call/model/call_model.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final int id;
  final int sessionRate;
  final String specialization;
  final String timezone;
  final String? image;
  final GestureTapCallback? tapOnProfile;

  const ChatAppbar(
      {Key? key,
      required this.name,
      required this.specialization,
      required this.id,
      this.tapOnProfile,
      required this.image,
      required this.sessionRate,
      required this.timezone})
      : preferredSize = const Size.fromHeight(75),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, right: 4, left: 4, bottom: 8),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            splashRadius: 24,
            onPressed: () {
              NavRouter.pop(context);
            },
            icon: const SvgImage(
              path: ic_backbutton,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: tapOnProfile,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  image == null || image!.isEmpty
                      ? CircleAvatar(
                          radius: 23,
                          backgroundImage:
                              AssetImage('assets/images/png/no_profile.png'),
                        )
                      : CircleAvatar(
                          radius: 23,
                          backgroundImage: CachedNetworkImageProvider(
                              VIDEO_BASE_URL + image!),
                        ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyles.boldTextStyle(fontSize: 16),
                        ),
                        Text(
                          specialization,
                          style: TextStyles.mediumTextStyle(
                              fontSize: 12, textColor: AppColors.moon),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          BlocConsumer<VideoCallCubit, VideoCallState>(
            listener: (context, state) {
              if (state is VideoCallLoaded) {
                print(sessionRate);
                print(timezone);
                if (state.error.isNotEmpty) {
                  if (state.error.contains('No Booking Found')) {
                  } else {
                    BotToast.showText(text: state.error);
                  }
                }
              }
            },
            builder: (context, state) {
              return state is VideoCallLoading
                  ? Center(
                      child: Transform.scale(
                          scale: 0.4, child: CircularProgressIndicator()),
                    )
                  : state is VideoCallLoaded
                      ? IconButton(
                          splashRadius: 24,
                          onPressed: () async {
                            if (state.enableCallButton) {
                              String channelName =
                                  'channelName_${UniqueKey().hashCode.toString()}';
                              var result = await Future.wait([
                                context
                                    .read<VideoCallCubit>()
                                    .callingUserStatus(id),
                                context
                                    .read<VideoCallCubit>()
                                    .getAgoraToken(channelName),
                              ]);
                              if (result[0] == true) {
                                Appdata.receiverId = id;
                                context.read<HomeCubit>().emitStartCall(
                                    callModel: CallModel(
                                        callId:
                                            'call_${UniqueKey().hashCode.toString()}',
                                        channelName: channelName,
                                        token: result[1].toString(),
                                        callerId: AuthRepo.instance.user.userId,
                                        userId: state.userId,
                                        doctorId: state.doctorId,
                                        bookingId: state.bookingId,
                                        callerAvatar:
                                            AuthRepo.instance.user.image,
                                        callerName:
                                            '${AuthRepo.instance.user.firstName} ${AuthRepo.instance.user.firstName}',
                                        receiverId: id,
                                        receiverAvatar: image ?? '',
                                        receiverName: name,
                                        status: CallStatus.ringing.name,
                                        receiverSpecialization: specialization,
                                        callerSpecialization: AuthRepo
                                            .instance.user.specialization,
                                        createAt: DateTime.now()
                                            .millisecondsSinceEpoch,
                                        current: 1));
                              }
                            } else {
                              CustomDialogs.showDayNotAvailableDialog(
                                  context,
                                  state.appointmentModel != null
                                      ? 'Please wait until your scheduled \n Appointment Time'
                                      : 'You don\'t have any active appointments to make videocall \n Please Book Appointment',
                                  state.appointmentModel != null
                                      ? 'View Appointment'
                                      : 'Book Appointment', onOkSelection: () {
                                print('tapped');
                                state.appointmentModel != null
                                    ? NavRouter.pushReplacement(
                                        context,
                                        AppointmentDetailScreen(
                                            appointmentModel:
                                                state.appointmentModel!))
                                    : NavRouter.pushReplacement(
                                        context,
                                        BookingSlotScreen(
                                            doctorId: id,
                                            doctorName: name,
                                            doctorImage: image ?? '',
                                            specialization: specialization,
                                            sessionRate: sessionRate,
                                            timeZone: timezone));
                              });
                            }
                          },
                          icon: Icon(
                            Icons.video_call,
                            size: 26,
                            color: AppColors.acmeBlue,
                          ),
                        )
                      : Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  final Size preferredSize;
}
