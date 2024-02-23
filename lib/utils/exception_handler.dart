import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../core/models/api_response.dart';

class ExceptionHandler {
  static ApiResponse _apiResponse = ApiResponse();

  static ApiResponse handleException(Object e) {
    if (e is DioError) {
      /// DIO server exceptions

      if (e.type == DioErrorType.response) {
        if (e.response != null) {
          _apiResponse = ApiResponse.fromJson(e.response?.data);
        }
      }
      if (e.type == DioErrorType.connectTimeout) {
        _apiResponse.result = 'error';
        _apiResponse.message = 'Check your connection!';
        _apiResponse.data = [];
      }

      /// Receive timeout exceptions

      else if (e.type == DioErrorType.receiveTimeout) {
        _apiResponse.result = 'error';
        _apiResponse.message =
            'Unable to connect to the server, Please try again';
        _apiResponse.data = [];
      }

      /// Other exceptions

      else if (e.type == DioErrorType.other) {
        if (e.message.contains('SocketException')) {
          _apiResponse.result = 'error';
          _apiResponse.message = 'No Internet Connection, Please try again';
          _apiResponse.data = [];
        }
      }
    } else if (e is PlatformException) {
      if (e.code == 'network_error') {
        _apiResponse.result = 'error';
        _apiResponse.message = 'Check your connection!';
        _apiResponse.data = [];
      } else if (e.code == 'sign_in_failed') {
        _apiResponse.result = 'error';
        _apiResponse.message = 'Something went wrong, Please try again.';
        _apiResponse.data = [];
      }
    }
    return _apiResponse;
  }
}
