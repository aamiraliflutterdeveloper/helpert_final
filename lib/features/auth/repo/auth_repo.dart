import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/prefs.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/rest_api_service.dart';
import '../../../utils/shared_preference_manager.dart';
import '../models/user_model.dart';
import 'i_auth_repo.dart';

class AuthRepo extends IAuthRepo {
  AuthRepo._constructor();

  static final AuthRepo instance = AuthRepo._constructor();

  UserModel user = UserModel.fromJson({});

  @override
  Future<bool> authApi(FormData formData, {bool isLoginApi = true}) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      isLoginApi ? kLoginApi : kSignUpApi,
      formData: formData,
      isTokenRequired: false,
    );

    if (apiResponse.result == 'success') {
      user = UserModel.fromJson(apiResponse.data);

      /// storing the session
      await saveAndUpdateSession(user);

      if (apiResponse.token != null) {
        PreferenceManager.instance.setString(Prefs.TOKEN, apiResponse.token!);
      }
      PreferenceManager.instance
          .setString(Prefs.USER_ROLE, user.userRole.toString());

      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  @override
  Future<bool> userDetailApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kUserDetailApi,
      formData: formData,
      isTokenRequired: true,
    );
    print(apiResponse.message);
    print(apiResponse.result);
    print("======");
    if (apiResponse.result == 'success') {
      user = UserModel.fromJson(apiResponse.data);

      /// storing the session
      await saveAndUpdateSession(user);
      // Saving token for session management
      if (apiResponse.token != null) {
        PreferenceManager.instance.setString(Prefs.TOKEN, apiResponse.token!);
      }
      PreferenceManager.instance
          .setString(Prefs.USER_ROLE, user.userRole.toString());
      return true;
    } else {
      print(apiResponse.message!);
      throw apiResponse.message!;
    }
  }

  Future<bool> editSpecializationApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KEditProfileSpecialization,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      user = UserModel.fromJson(apiResponse.data);

      /// storing the session
      await saveAndUpdateSession(user);

      // Saving token for session management
      if (apiResponse.token != null) {
        PreferenceManager.instance.setString(Prefs.TOKEN, apiResponse.token!);
      }
      PreferenceManager.instance
          .setString(Prefs.USER_ROLE, user.userRole.toString());

      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  @override
  Future<bool> postUserInterestApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kPostUserInterestApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      user = UserModel.fromJson(apiResponse.data);

      /// storing the session
      await saveAndUpdateSession(user);
      // Saving token for session management
      if (apiResponse.token != null) {
        PreferenceManager.instance.setString(Prefs.TOKEN, apiResponse.token!);
      }
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> completeProfileApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kRegisterDetailApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      user = UserModel.fromJson(apiResponse.data);

      /// storing the session
      await saveAndUpdateSession(user);
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  @override
  String getName() {
    Map<String, dynamic> map =
        jsonDecode(PreferenceManager.instance.getString(Prefs.USER));
    UserModel userModel = UserModel.fromJson(map);
    return userModel.firstName;
  }

  @override
  String getToken() {
    return PreferenceManager.instance.getString(Prefs.TOKEN);
  }

  String getUserRole() {
    return PreferenceManager.instance.getString(Prefs.USER_ROLE);
  }

  @override
  Future<bool> logout() async {
    await deleteSession();
    ApiResponse apiResponse = await RestApiService.instance.postUri(kLogoutApi);
    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  @override
  Map<String, dynamic> getHeaders() {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + getToken()
    };
  }

  @override
  String getProvider() {
    throw UnimplementedError();
  }

  String getStep() {
    return PreferenceManager.instance.getString(Prefs.STEP);
  }

  Future<void> saveAndUpdateSession(UserModel userModel) async {
    user = userModel;
    PreferenceManager.instance.setString(Prefs.USER, jsonEncode(userModel));
    PreferenceManager.instance.setString(Prefs.PROVIDER, userModel.provider);
    PreferenceManager.instance
        .setString(Prefs.STEP, userModel.isProfileCompleted.toString());
  }

  Future initiateAppLevelSession() async {
    String userString = PreferenceManager.instance.getString(Prefs.USER);
    if (userString == '') return {};

    ///
    Map<String, dynamic> userMap =
        jsonDecode(PreferenceManager.instance.getString(Prefs.USER));
    user = UserModel.fromJson(userMap);
  }

  Future<void> deleteSession() async {
    await PreferenceManager.instance.clear();
    // delete fcm token
  }
}
