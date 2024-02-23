import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/appointment/bloc/appointment_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/available_slots_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/calendar_data_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/save_slot_bloc.dart';
import 'package:helpert_app/features/chat/cubit/chat_cubit.dart';
import 'package:helpert_app/features/chat/cubit/video_call_cubit.dart';
import 'package:helpert_app/features/notifications/bloc/notification_bloc.dart';
import 'package:helpert_app/features/profile/bloc/add_slot_bloc.dart';
import 'package:helpert_app/features/profile/bloc/profile_bloc.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/bloc/payment_bloc.dart';
import 'package:helpert_app/features/video/bloc/comment/comment_bloc.dart';
import 'package:helpert_app/features/video/bloc/video/delete_video_bloc.dart';
import 'package:helpert_app/features/video/bloc/video/fetch_all_videos_bloc.dart';
import 'package:helpert_app/features/video/bloc/video/share_video_bloc.dart';
import 'package:helpert_app/features/video_call/bloc/call/call_cubit.dart';
import 'package:helpert_app/features/video_call/bloc/review/review_bloc.dart';
import 'package:helpert_app/features/video_update/bloc/update_video_bloc.dart';

import '../features/auth/bloc/auth_bloc.dart';
import '../features/chat/cubit/recent_chat_cubit.dart';
import '../features/home/bloc/speciality_bloc.dart';
import '../features/new_video_upload/bloc/fetch_user_video_bloc.dart';
import '../features/new_video_upload/bloc/interest_bloc.dart';
import '../features/new_video_upload/bloc/video_bloc.dart';
import '../features/new_video_upload/bloc/video_view_bloc.dart';
import '../features/other_user_profile/bloc/other_profile_bloc.dart';
import '../features/other_user_profile/bloc/other_profile_video_bloc.dart';
import '../features/profile/bloc/edit_profile_specialization_bloc.dart';
import '../features/profile/bloc/my_earning_bloc.dart';
import '../features/video/bloc/notification_count/appointment_count_bloc.dart';
import '../features/video/bloc/notification_count/message_count_bloc.dart';
import '../features/video/bloc/notification_count/notification_count_bloc.dart';
import '../features/video/bloc/recommended_question/recommended_question_cubit.dart';
import '../features/video_call/bloc/home/home_cubit.dart';

List<BlocProvider> multiBlocProviders() {
  return [
    BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
    BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),

    BlocProvider<VideoBloc>(create: (_) => VideoBloc()),
    BlocProvider<CommentBloc>(create: (_) => CommentBloc()),
    BlocProvider<FetchAllVideosBloc>(create: (_) => FetchAllVideosBloc()),
    BlocProvider<FetchUserVideoBloc>(create: (_) => FetchUserVideoBloc()),
    BlocProvider<DeleteVideoBloc>(create: (_) => DeleteVideoBloc()),
    BlocProvider<UpdateVideoBloc>(create: (_) => UpdateVideoBloc()),
    BlocProvider<ShareVideoBloc>(create: (_) => ShareVideoBloc()),
    BlocProvider<RecommendedQuestionCubit>(
        create: (_) => RecommendedQuestionCubit()),
    BlocProvider<OtherProfileBloc>(create: (_) => OtherProfileBloc()),
    BlocProvider<OtherProfileVideoBloc>(create: (_) => OtherProfileVideoBloc()),
    BlocProvider<EditProfileSpecializationBloc>(
        create: (_) => EditProfileSpecializationBloc()),
    BlocProvider<AddSlotsBloc>(create: (_) => AddSlotsBloc()),
    BlocProvider<AvailableSlotsBloc>(create: (_) => AvailableSlotsBloc()),
    // BlocProvider<FetchMenuSpecializationBloc>(
    //     create: (_) => FetchMenuSpecializationBloc()),
    BlocProvider<AddSlotsBloc>(create: (_) => AddSlotsBloc()),
    BlocProvider<AvailableSlotsBloc>(create: (_) => AvailableSlotsBloc()),
    BlocProvider<SaveSlotBloc>(create: (_) => SaveSlotBloc()),
    BlocProvider<AppointmentsBloc>(create: (_) => AppointmentsBloc()),
    BlocProvider<CalendarDataBloc>(create: (_) => CalendarDataBloc()),
    BlocProvider<NotificationBloc>(create: (_) => NotificationBloc()),
    BlocProvider<PaymentBloc>(create: (_) => PaymentBloc()),
    BlocProvider<VideoViewBloc>(create: (_) => VideoViewBloc()),
    // chat
    BlocProvider<RecentChatCubit>(create: (_) => RecentChatCubit()),
    BlocProvider<ChatCubit>(create: (_) => ChatCubit()),
    BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
    BlocProvider<CallCubit>(create: (_) => CallCubit()),
    BlocProvider<VideoCallCubit>(create: (_) => VideoCallCubit()),
    BlocProvider<NotificationCountBloc>(create: (_) => NotificationCountBloc()),
    BlocProvider<MessageCountBloc>(create: (_) => MessageCountBloc()),
    BlocProvider<AppointmentCountBloc>(create: (_) => AppointmentCountBloc()),

    BlocProvider<SpecialityBloc>(create: (_) => SpecialityBloc()),
    BlocProvider<InterestBloc>(create: (_) => InterestBloc()),
    BlocProvider<ReviewBloc>(create: (_) => ReviewBloc()),
    BlocProvider<MyEarningBloc>(create: (_) => MyEarningBloc()),
  ];
}
