import 'package:dio/dio.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';
import 'package:helpert_app/features/profile/models/unAvailAbleDateModel.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/rest_api_service.dart';
import '../../auth/models/user_model.dart';
import '../models/my_earning_model.dart';

class ProfileRepo {
  ProfileRepo.privateConstructor();

  static final ProfileRepo instance = ProfileRepo.privateConstructor();

  Future<bool> fetchProfileApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kFetchProfileApi,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      UserModel user = UserModel.fromJson(apiResponse.data);
      await AuthRepo.instance.saveAndUpdateSession(user);
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> updateProfileApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kUpdateProfileApi,
      formData: formData,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      UserModel user = UserModel.fromJson(apiResponse.data);
      await AuthRepo.instance.saveAndUpdateSession(user);
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> setSessionRateApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KSessionRateApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<DaysListModel> fetchSlotDaysApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kFetchSlotDaysApi,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      return DaysListModel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<UnavailableDateListModel> fetchUnavailableDatesApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kFetchUnavailableDatesApi,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      return UnavailableDateListModel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> addDaySlotsApi(Map<String, dynamic> rawData) async {
    ApiResponse apiResponse = await RestApiService.instance.postRawDataUri(
      kAddDaySlotsApi,
      rawData: rawData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> addUnavailableDaysApi(Map<String, dynamic> rawData) async {
    ApiResponse apiResponse = await RestApiService.instance.postRawDataUri(
      kAddUnavailableDaysApi,
      rawData: rawData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  /// My Earning Screen
  Future<MyEarningModel> myEarningApi() async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kGetAccountBalance,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      MyEarningModel myEarnings = MyEarningModel.fromJson(apiResponse.data);
      return myEarnings;
    } else {
      throw apiResponse.message!;
    }
  }
}
