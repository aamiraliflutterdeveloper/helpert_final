import 'package:dio/dio.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/rest_api_service.dart';
import '../../auth/models/user_model.dart';
import '../../video/model/videos_model.dart';

class OtherProfileRepo {
  OtherProfileRepo.privateConstructor();

  static final OtherProfileRepo instance =
      OtherProfileRepo.privateConstructor();

  Future<UserModel> getSpecificUserApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KSpecificUserGetProfileApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      UserModel otherUser = UserModel.fromJson(apiResponse.data);
      return otherUser;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<AllVideosModel> fetchOtherProfileVideoApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KOtherProfileVideosApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      AllVideosModel videosData = AllVideosModel.fromJson(apiResponse.data);
      return videosData;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> followUnfollowApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KUserFollowUnfollowApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }
}
