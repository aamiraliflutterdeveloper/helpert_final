import 'package:dio/dio.dart';
import 'package:helpert_app/features/appointment/model/appointment_model.dart';
import 'package:helpert_app/features/book_call/model/booking_model.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/rest_api_service.dart';

class HomeRepo {
  HomeRepo.privateConstructor();

  static final HomeRepo instance = HomeRepo.privateConstructor();

  Future<bool> callingUserStatus(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kCallingUserStatus,
      formData: formData,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<String> getAgoraToken(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kGetAgoraToken,
      formData: formData,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      String agoraToken = apiResponse.data;
      return agoraToken;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<List<BookingModel>> getUserBooking(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kGetUserBooking,
      formData: formData,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      List<BookingModel> bookingList = List<BookingModel>.from(
          apiResponse.data.map((x) => BookingModel.fromJson(x)));

      return bookingList;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<AppointmentModel> getAppointment(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kGetAppointment,
      formData: formData,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      AppointmentModel appointmentModel =
          AppointmentModel.fromJson(apiResponse.data);

      return appointmentModel;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> bookingRating(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kRating,
      formData: formData,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> checkRating(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kCheckRating,
      formData: formData,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      print('apiResponse.data');
      print(apiResponse.data);
      return true;
    } else {
      print('apiResponse.message');
      print(apiResponse.message);

      throw apiResponse.message!;
    }
  }
}
