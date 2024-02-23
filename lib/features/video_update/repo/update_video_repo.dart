import 'package:dio/dio.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/rest_api_service.dart';

class UpdateVideoRepo {
  UpdateVideoRepo.privateConstructor();
  static final UpdateVideoRepo instance = UpdateVideoRepo.privateConstructor();

  Future<bool> updateVideoApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kUpdateVideoApi,
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
