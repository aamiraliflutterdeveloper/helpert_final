class PaymentSettingDataModel {
  String image;
  String title;
  String subTitle;
  bool isVerified;
  PaymentSettingDataModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.isVerified});
}

// List<PaymentSettingDataModel> paymentSettingsList = [
//   PaymentSettingDataModel(
//       image: upi_payment_icon,
//       title: 'UPI Payments',
//       subTitle: 'Add UPI Payments.'),
//   PaymentSettingDataModel(
//       image: card_payment_icon, title: 'Cards', subTitle: 'Add Payment Cards.'),
//   PaymentSettingDataModel(
//       image: paypal_icon, title: 'Paypal', subTitle: 'Connect to your Paypal.'),
// ];
