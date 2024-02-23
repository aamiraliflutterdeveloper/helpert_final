import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/profile/bloc/profile_state.dart';
import 'package:helpert_app/features/profile/repo/profile_repo.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(InitialState());

  // bool profileFetched = false;

  Future<void> fetchProfile({bool loading = true}) async {
    try {
      // if (profileFetched == false)
      if (loading) emit(ProfileLoading());
      bool result = await ProfileRepo.instance.fetchProfileApi();
      if (result) {
        // profileFetched = true;
        emit(ProfileLoaded());
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> setSessionRate(int sessionRate) async {
    emit(ProfileLoading());
    try {
      var data = FormData.fromMap({
        'session_rate': sessionRate,
      });
      bool result = await ProfileRepo.instance.setSessionRateApi(data);
      if (result) emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> fetchSlotDays() async {
    try {
      emit(ProfileLoading());
      List result = await Future.wait([
        ProfileRepo.instance.fetchSlotDaysApi(),
        ProfileRepo.instance.fetchUnavailableDatesApi()
      ]);
      emit(ProfileLoaded(
          daysListModel: result[0], unavailableDateListModel: result[1]));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(String email, String userName, String firstName,
      String lastName, String dob, File? file) async {
    emit(ProfileUpdating());
    try {
      MultipartFile? image;
      if (file != null) {
        String fileName = file.path.split('/').last;
        image = await MultipartFile.fromFile(file.path, filename: fileName);
      }
      var data = FormData.fromMap({
        'email': email,
        'username': userName,
        'first_name': firstName,
        'last_name': lastName,
        'dob': dob,
        "image": image
      });
      bool result = await ProfileRepo.instance.updateProfileApi(data);
      if (result) emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
