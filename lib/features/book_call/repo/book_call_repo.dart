import 'package:dio/dio.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/core/models/api_response.dart';
import 'package:helpert_app/core/services/rest_api_service.dart';
import 'package:helpert_app/features/book_call/model/booking_model.dart';
import 'package:helpert_app/features/book_call/model/calendar_data_model.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';

class BookCallRepo {
  BookCallRepo.privateConstructor();

  static final BookCallRepo instance = BookCallRepo.privateConstructor();

  Future<DaysModel> availableSlotsApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kAvailableSlotsApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      DaysModel daysModel = DaysModel.fromJson(apiResponse.data);
      return daysModel;
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
      throw apiResponse.message ?? 'Something went wrong, please try again.';
    }
  }

  Future<CalendarDataModel> fetchCalendarData(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KCalendarMappingApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      CalendarDataModel calendarDataModel =
          CalendarDataModel.fromJson(apiResponse.data);
      return calendarDataModel;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<List<CalendarDaysModel>> fetchAvailableDays(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kAvailableDaysApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      List<CalendarDaysModel> calendarDaysList = List<CalendarDaysModel>.from(
          apiResponse.data.map((x) => CalendarDaysModel.fromJson(x)));

      return calendarDaysList;
    } else {
      throw apiResponse.message!;
    }
  }
}
