import 'dart:developer';

import 'package:dio/dio.dart';

import '../../features/auth/repo/auth_repo.dart';
import '../../utils/exception_handler.dart';
import '../models/api_response.dart';

class RestApiService {
  Dio dio = Dio();

  RestApiService._privateConstructor();

  static final RestApiService _instance = RestApiService._privateConstructor();

  static RestApiService get instance => _instance;

  /// Post API ---
  Future<ApiResponse> postUri(String url,
      {FormData? formData,
      Map<String, dynamic>? rawData,
      bool isTokenRequired = true,
      Function(int senderValue, int receiverValue)? videoStatus}) async {
    log('get headers :: ${AuthRepo.instance.getHeaders()}');
    ApiResponse apiResponse = ApiResponse();
    try {
      // api post call
      final response = await Dio().postUri(Uri.parse(url),
          onSendProgress: videoStatus,
          data: formData,
          options: isTokenRequired
              ? Options(headers: AuthRepo.instance.getHeaders())
              : null);

      // response management
      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse = ApiResponse.fromJson(response.data);
      }
    } catch (e) {
      apiResponse = ExceptionHandler.handleException(e);
    }
    return apiResponse;
  }

  Future<ApiResponse> postRawDataUri(String url,
      {Map<String, dynamic>? rawData, bool isTokenRequired = true}) async {
    log('get headers :: ${AuthRepo.instance.getHeaders()}');
    ApiResponse apiResponse = ApiResponse();
    try {
      // api post call
      final response = await Dio().postUri(Uri.parse(url),
          data: rawData,
          options: isTokenRequired
              ? Options(headers: AuthRepo.instance.getHeaders())
              : null);

      // response management
      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse = ApiResponse.fromJson(response.data);
      }
    } catch (e) {
      apiResponse = ExceptionHandler.handleException(e);
    }
    return apiResponse;
  }

  /// Get API ---
  Future<ApiResponse> getUri(String url,
      {Map<String, dynamic>? queryParams, bool isTokenRequired = true}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      // api post call
      final response = await Dio().get(
        url,
        queryParameters: queryParams,
        options: isTokenRequired
            ? Options(headers: AuthRepo.instance.getHeaders())
            : null,
      );
      if (response.statusCode == 200) {
        apiResponse = ApiResponse.fromJson(response.data);
      }
    } catch (e) {
      apiResponse = ExceptionHandler.handleException(e);
    }
    return apiResponse;
  }
}
