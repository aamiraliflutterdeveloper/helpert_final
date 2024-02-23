import 'package:helpert_app/features/profile/screens/payment_settings/model/stripe_aacount_model.dart';

import '../model/stripe_account_link_model.dart';

abstract class PaymentState {}

class InitialPaymentState extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentAccountLoaded extends PaymentState {
  final StripeAccountModel stripeAccountModel;

  PaymentAccountLoaded({required this.stripeAccountModel});
}

class PaymentCreateAccountLoaded extends PaymentState {
  final StripeAccountModel stripeAccountModel;

  PaymentCreateAccountLoaded({required this.stripeAccountModel});
}

class PaymentAccountLinkLoaded extends PaymentState {
  final StripeAccountLinkModel stripeAccountLinkModel;

  PaymentAccountLinkLoaded({required this.stripeAccountLinkModel});
}

class PaymentError extends PaymentState {
  final String error;

  PaymentError(this.error);
}
