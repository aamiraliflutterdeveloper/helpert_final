import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import '../../../core/services/notifications/cloud_messaging_service.dart';
import '../models/social_user_model.dart';
import '../repo/auth_repo.dart';
import '../repo/social_auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(InitialState());

  Future<void> login(String email, String password) async {
    String? token = await CloudMessagingService.instance.getToken();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    log('Time zone :: $currentTimeZone');
    emit(AuthLoading());
    try {
      var data = FormData.fromMap({
        'login': email,
        'password': password,
        'fcm_token': token,
        'timezone': currentTimeZone,
      });
      bool result = await AuthRepo.instance.authApi(data);
      if (result) emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    String? token = await CloudMessagingService.instance.getToken();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    log('Time zone :: $currentTimeZone');

    emit(AuthLoading());
    try {
      var data = FormData.fromMap({
        'email': email,
        'password': password,
        'fcm_token': token,
        'timezone': currentTimeZone,
      });
      bool result = await AuthRepo.instance.authApi(data, isLoginApi: false);
      if (result) emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  SocialUserModel? socialUserModel;

  Future<void> completeProfile(
      String username, String firstName, String lastName, String date) async {
    emit(AuthLoading());
    try {
      var data = FormData.fromMap({
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'dob': date,
      });
      bool result = await AuthRepo.instance.completeProfileApi(data);
      if (result) emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> userDetail(Map<String, dynamic> userDate) async {
    emit(AuthLoading());
    try {
      var data = FormData.fromMap(userDate);
      bool result = await AuthRepo.instance.userDetailApi(data);
      print(result);
      if (result) emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> postUserInterest(Map<String, dynamic> userDate) async {
    emit(AuthLoading());
    var data = FormData.fromMap(userDate);
    bool result = await AuthRepo.instance.postUserInterestApi(data);
    if (result) emit(AuthLoaded());
    try {} catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<bool> fetchSocialAuthData(String provider, int type) async {
    try {
      socialUserModel =
          await SocialAuthRepository.instance.socialAuth(provider, type);
      return true;
    } catch (e) {
      emit(SocialError(e.toString()));
      return false;
    }
  }

  Future<void> socialLogin() async {
    emit(SocialAuthLoading());
    try {
      var data = FormData.fromMap(socialUserModel!.toJson());
      await SocialAuthRepository.instance.socialAuthApi(data);
      emit(AuthLoaded());
    } catch (e) {
      emit(SocialError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      bool result = await AuthRepo.instance.logout();
      if (result) emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  String? emailValidation(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid && email.isNotEmpty) {
      return 'Email not valid.';
    } else {
      return null;
    }
  }

  String? firstNameValidation(String firstName) {
    bool specialChar = RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(firstName);

    if (!specialChar && firstName.isNotEmpty) {
      return 'Special character not allowed';
    } else if (firstName.contains(RegExp(r'[0-9]')) && firstName.isNotEmpty) {
      return 'Digit not allowed';
    } else {
      return null;
    }
  }

  String? lastNameValidation(String lastName) {
    bool specialChar = RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(lastName);

    if (!specialChar && lastName.isNotEmpty) {
      return 'Special character not allowed';
    } else if (lastName.contains(RegExp(r'[0-9]')) && lastName.isNotEmpty) {
      return 'Digit not allowed';
    } else {
      return null;
    }
  }

  String? userNameValidation(String userName) {
    if (userName.contains(' ') && userName.isNotEmpty) {
      return 'Space is not allowed';
    } else {
      return null;
    }
  }

  String? locationValidation(String location) {
    if (location.isEmpty) {
      return 'Please enter your location';
    } else {
      return null;
    }
  }

  String? passwordValidation(String password) {
    if (password.isNotEmpty && password.length <= 7) {
      return 'Password should be grater then 8 characters.';
    } else {
      return null;
    }
  }
}
