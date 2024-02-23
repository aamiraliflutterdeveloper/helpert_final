class PaymentSettingData {
  String image;
  String title;
  String subTitle;
  PaymentSettingData(
      {required this.subTitle, required this.title, required this.image});
}

List<PaymentSettingData> paymentSettingList = [
  PaymentSettingData(subTitle: 'subTitle', title: 'title', image: 'image')
];
