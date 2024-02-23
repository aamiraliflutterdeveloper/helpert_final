import 'package:dio/dio.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/core/models/api_response.dart';
import 'package:helpert_app/core/services/rest_api_service.dart';

import '../model/stripe_aacount_model.dart';
import '../model/stripe_account_link_model.dart';

class PaymentRepo {
  PaymentRepo.privateConstructor();

  static final PaymentRepo instance = PaymentRepo.privateConstructor();

  Future<StripeAccountModel> getStripeAccountApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KGetStripeAccountApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      StripeAccountModel stripeAccountModel =
          StripeAccountModel.fromJson(apiResponse.data);
      return stripeAccountModel;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<void> changePaymentStatusApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KChangePaymentStatusApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
    } else {
      throw apiResponse.message!;
    }
  }

  Future<StripeAccountModel> createStripeAccountApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KCreateStripeAccountApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      StripeAccountModel stripeAccountModel =
          StripeAccountModel.fromJson(apiResponse.data);
      return stripeAccountModel;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<StripeAccountLinkModel> createStripeAccountLinkApi(
      FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KCreateStripeAccountLinkApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      StripeAccountLinkModel stripeAccountLinkModel =
          StripeAccountLinkModel.fromJson(apiResponse.data);
      return stripeAccountLinkModel;
    } else {
      throw apiResponse.message!;
    }
  }
}
