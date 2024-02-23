import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/bloc/payment_state.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/model/stripe_aacount_model.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/model/stripe_account_link_model.dart';
import 'package:helpert_app/features/profile/screens/payment_settings/repo/payment_repo.dart';
import 'package:helpert_app/features/reusable_video_list/app_data.dart';

class PaymentBloc extends Cubit<PaymentState> {
  PaymentBloc() : super(InitialPaymentState());
  bool alreadyVisited = false;
  Future<void> getStripeAccount(String accountId,
      {bool accountExist = true}) async {
    emit(PaymentLoading());
    try {
      var data = FormData.fromMap({
        'account_id': accountId,
      });
      StripeAccountModel result =
          await PaymentRepo.instance.getStripeAccountApi(data);
      // Appdata.chargesEnabled = result.chargesEnabled;
      // Appdata.detailsSubmitted = result.detailsSubmitted;
      // AuthRepo.instance.user.stripeId = result.id;
      // if (accountExist) {
      //   if (AuthRepo.instance.user.stripeId.isEmpty) {
      //     createStripeAccount(AuthRepo.instance.user.email);
      //   } else {
      //     if (!result.detailsSubmitted) {
      //       if (alreadyVisited) {
      //         emit(PaymentError('No account found'));
      //       } else {
      //         createStripeAccountLink(AuthRepo.instance.user.stripeId);
      //       }
      //     } else {
      //       if (result.detailsSubmitted && result.chargesEnabled) {
      //         await changePaymentStatus(AuthRepo.instance.user.userId);
      //       }
      //       emit(PaymentAccountLoaded(stripeAccountModel: result));
      //     }
      //   }
      // } else {
      //   emit(PaymentAccountLoaded(stripeAccountModel: result));
      // }
      if (result.detailsSubmitted && result.chargesEnabled) {
        await changePaymentStatus(AuthRepo.instance.user.userId);
      }
      print('First Result is ${result.toJson()}');
      emit(PaymentAccountLoaded(stripeAccountModel: result));
    } catch (e) {
      if (accountExist) {
        if (e == "Stripe Id  not found.") {
          emit(PaymentLoading());
          createStripeAccount(AuthRepo.instance.user.email);
        }
        if (e.toString().contains('does not have access to account')) {
          emit(PaymentLoading());
          createStripeAccount(AuthRepo.instance.user.email);
        } else {
          emit(PaymentError(e.toString()));
        }
      } else {
        emit(PaymentError(e.toString()));
      }
    }
  }

  Future<void> changePaymentStatus(int doctorId) async {
    try {
      var data = FormData.fromMap({
        'doctor_id': doctorId,
        'payment_status': 'complete',
      });

      await PaymentRepo.instance.changePaymentStatusApi(data);
    } catch (e) {
      debugPrint('');
    }
  }

  Future<void> createStripeAccount(String email) async {
    try {
      var data = FormData.fromMap({
        'email': email,
      });
      StripeAccountModel result =
          await PaymentRepo.instance.createStripeAccountApi(data);
      Appdata.chargesEnabled = result.chargesEnabled;
      Appdata.detailsSubmitted = result.detailsSubmitted;
      AuthRepo.instance.user.stripeId = result.id;
      print('Second Result is ${result.toJson()}');

      emit(PaymentAccountLoaded(stripeAccountModel: result));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> createStripeAccountLink(String accountId) async {
    alreadyVisited = true;
    try {
      var data = FormData.fromMap({
        'account_id': accountId,
      });
      StripeAccountLinkModel result =
          await PaymentRepo.instance.createStripeAccountLinkApi(data);
      emit(PaymentAccountLinkLoaded(stripeAccountLinkModel: result));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
