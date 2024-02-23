import 'package:dio/dio.dart';

abstract class IAuthRepo {
  Future<bool> authApi(FormData formData, {bool isLoginApi});
  Future<bool> userDetailApi(FormData formData);
  Future<bool> postUserInterestApi(FormData formData);

  String getName();

  String getToken();

  Map<String, dynamic> getHeaders();

  String getProvider();

  Future<bool> logout();
}
