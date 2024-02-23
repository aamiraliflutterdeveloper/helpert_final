import 'package:dio/dio.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/core/models/api_response.dart';
import 'package:helpert_app/core/services/rest_api_service.dart';
import 'package:helpert_app/features/appointment/model/appointment_model.dart';
import 'package:helpert_app/features/book_call/model/booking_model.dart';

class AppointmentRepo {
  AppointmentRepo.privateConstructor();

  static final AppointmentRepo instance = AppointmentRepo.privateConstructor();

  Future<List<AppointmentModel>> appointments() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      KAppointmentsApi,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      List<AppointmentModel> appointments = List<AppointmentModel>.from(
          apiResponse.data.map((x) => AppointmentModel.fromJson(x)));
      return appointments;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<BookingModel> saveBookingSlotApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kBookingSlotSaveApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      BookingModel bookingModel =
          BookingModel.fromJson(apiResponse.data['booing']);
      return bookingModel;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> approveBookingApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KApproveBookingApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> declineBookingApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KDeclineBookingApi,
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
