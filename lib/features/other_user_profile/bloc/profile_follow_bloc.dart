import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/other_profile_repo.dart';
import 'profile_follow_state.dart';

class ProfileFollowBloc extends Cubit<ProfileFollowState> {
  ProfileFollowBloc() : super(InitialState());

  Future<void> followUnfollow(int userId) async {
    emit(ProfileFollowLoading());
    try {
      var data = FormData.fromMap({
        'user_follow_id': userId,
      });
      bool result = await OtherProfileRepo.instance.followUnfollowApi(data);
      if (result) emit(ProfileFollowLoaded());
    } catch (e) {
      emit(ProfileFollowError(e.toString()));
    }
  }
}
