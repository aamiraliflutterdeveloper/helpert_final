import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/models/user_model.dart';
import 'package:helpert_app/features/other_user_profile/repo/other_profile_repo.dart';
import 'package:helpert_app/features/reusable_video_list/app_data.dart';

import 'other_profile_state.dart';

class OtherProfileBloc extends Cubit<OtherProfileState> {
  OtherProfileBloc() : super(InitialState());

  Future<void> getSpecificUser(int userId) async {
    emit(OtherProfileLoading());
    try {
      var data = FormData.fromMap({
        'user_id': userId,
      });
      UserModel result =
          await OtherProfileRepo.instance.getSpecificUserApi(data);
      if (result.firstName.isNotEmpty) emit(OtherProfileLoaded(user: result));
    } catch (e) {
      emit(OtherProfileError(e.toString()));
    }
  }

  Future<void> followUnFollow(int userId) async {
    try {
      var data = FormData.fromMap({
        'user_follow_id': userId,
      });
      final currentState = state;
      if (currentState is OtherProfileLoaded) {
        UserModel currentUser = currentState.user;
        if (currentUser.isFollow) {
          currentUser.followers--;
          currentUser.isFollow = false;
          Appdata.isFollowing.clear();
          Appdata.isFollowing.add(0);
          // currentUser.isFollow = 0;
        } else {
          Appdata.isFollowing.clear();
          currentUser.isFollow = true;
          Appdata.isFollowing.add(1);
          currentUser.followers++;
        }
        emit(OtherProfileLoaded(user: currentUser));
      }
      await OtherProfileRepo.instance.followUnfollowApi(data);
    } catch (e) {
      emit(OtherProfileError(e.toString()));
    }
  }
}
