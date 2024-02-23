import 'package:dio/dio.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/core/models/api_response.dart';
import 'package:helpert_app/core/services/rest_api_service.dart';
import 'package:helpert_app/features/notifications/model/notification_model.dart';

class NotificationRepo {
  NotificationRepo.privateConstructor();

  static final NotificationRepo instance =
      NotificationRepo.privateConstructor();

  Future<List<NotificationModel>> fetchNotificationsApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      KNotificationApi,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      List<NotificationModel> notifications = List<NotificationModel>.from(
          apiResponse.data['notificatioin']
              .map((x) => NotificationModel.fromJson(x)));
      return notifications;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> readNotificationApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KReadNotificationApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> updateNotificationCountApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KUpdateNotificationCountApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
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
