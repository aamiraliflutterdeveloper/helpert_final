import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/extension.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/book_call/bloc/save_slot_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/save_slot_state.dart';
import 'package:helpert_app/features/book_call/screens/payment_failed_screen.dart';
import 'package:helpert_app/features/book_call/screens/payment_success_screen.dart';
import 'package:helpert_app/features/video/bloc/notification_count/notification_count_bloc.dart';
import 'package:helpert_app/utils/scroll_behavior.dart';

import '../../../common_widgets/components/text_view.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/masked_textcontroller.dart';
import '../../../utils/nav_router.dart';

class PaymentScreen extends StatefulWidget {
  final String appointmentDescription;
  final int sessionRate;
  final int doctorId;
  final int slotId;
  final int dayId;
  final String date;
  const PaymentScreen(
      {Key? key,
      required this.appointmentDescription,
      required this.sessionRate,
      required this.doctorId,
      required this.slotId,
      required this.dayId,
      required this.date})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '000');

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.silver,
              ),
              BlocConsumer<SaveSlotBloc, SaveSlotState>(
                  listener: (context, state) {
                if (state is SaveSlotLoading) {
                  BotToast.showLoading();
                } else if (state is SaveSlotError) {
                  BotToast.closeAllLoading();
                  BotToast.showText(text: state.error);
                  NavRouter.push(context, PaymentFailedScreen());
                } else if (state is SaveSlotLoaded) {
                  BotToast.closeAllLoading();

                  NotificationCountBloc.get(context)
                      .emitNotificationCount(receiverId: widget.doctorId);
                  NavRouter.push(context, PaymentSuccessScreen());
                }
              }, builder: (context, state) {
                return Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.acmeBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () {
                      print(widget.appointmentDescription);
                      print(widget.doctorId);
                      print(widget.date);
                      print(widget.sessionRate);
                      print(widget.slotId);
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        context.read<SaveSlotBloc>().saveBookingSlot(
                            widget.appointmentDescription,
                            widget.doctorId,
                            widget.date,
                            widget.slotId,
                            int.parse(
                                _cardNumberController.text.replaceAll(' ', '')),
                            int.parse(
                                _expiryDateController.text.substring(0, 2)),
                            2000 +
                                int.parse(
                                    _expiryDateController.text.lastChars(2)),
                            int.parse(_cvvCodeController.text),
                            'card',
                            widget.dayId);
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          'Confirm Payment',
                          textStyle: TextStyles.semiBoldTextStyle(
                              textColor: AppColors.pureWhite),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          width: 2,
                          height: 14,
                          color: Color(0xFFFFFEFC).withOpacity(.4),
                        ),
                        TextView(
                          '\$${widget.sessionRate}',
                          textStyle: TextStyles.semiBoldTextStyle(
                              textColor: AppColors.pureWhite),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        appBar: CustomAppBar(
          title: 'Payment',
          hasElevation: true,
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24) +
                EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  'Payment method',
                  textStyle: TextStyles.regularTextStyle(
                      fontSize: 20, textColor: AppColors.black),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 5,
                        color: AppColors.moon.withOpacity(.6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ic_visa,
                            width: 25,
                            height: 16,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Image.asset(
                            ic_master,
                            width: 25,
                            height: 16,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextView('Credit card',
                          textStyle: TextStyles.mediumTextStyle(fontSize: 14))
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ic_visa,
                                    width: 51,
                                    height: 26,
                                  ),
                                  Image.asset(
                                    ic_master,
                                    width: 51,
                                    height: 26,
                                  ),
                                  Image.asset(
                                    ic_discover,
                                    width: 51,
                                    height: 26,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Image.asset(
                                    ic_amex,
                                    width: 51,
                                    height: 26,
                                  ),
                                ],
                              ),
                            ),
                            SvgImage(
                              path: ic_lock,
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextView(
                          'Card Number',
                          textStyle: TextStyles.mediumTextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                            obscureText: false,
                            controller: _cardNumberController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            autofillHints: const <String>[
                              AutofillHints.creditCardNumber
                            ],
                            validator: (String? value) {
                              // Validate less that 13 digits +3 white spaces
                              if (value!.isEmpty || value.length < 16) {
                                return 'Please enter a valid card';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {});
                            },
                            decoration: _cardNumberDecoration),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            TextView(
                              'Expiry Date',
                              textStyle: TextStyles.mediumTextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            TextView(
                              '(MM/YY)',
                              textStyle: TextStyles.mediumTextStyle(
                                  fontSize: 13, textColor: Color(0xFFAEB5BC)),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _expiryDateController,
                          autofillHints: const <String>[
                            AutofillHints.creditCardExpirationDate
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid date';
                            }
                            final DateTime now = DateTime.now();
                            final List<String> date = value.split(RegExp(r'/'));
                            final int month = int.parse(date.first);
                            final int year = int.parse('20${date.last}');
                            final DateTime cardDate = DateTime(year, month);

                            if (cardDate.isBefore(now) ||
                                month > 12 ||
                                month == 0) {
                              return 'Please entere a valid date';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {});
                          },
                          decoration: _expiryDateDecoration,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            TextView(
                              'CVV',
                              textStyle: TextStyles.mediumTextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            TextView(
                              '(3 digits)',
                              textStyle: TextStyles.mediumTextStyle(
                                  fontSize: 13, textColor: Color(0xFFAEB5BC)),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _cvvCodeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            setState(() {});
                          },
                          decoration: _cvcDecoration,
                          validator: (String? value) {
                            if (value!.isEmpty || value.length < 3) {
                              return 'Enter a valid cvv number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                TextView(
                  'Safe and secure payments by stripe',
                  textStyle: TextStyles.regularTextStyle(
                      fontSize: 14, textColor: Color(0xFF3C4447)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final _cardNumberDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.pureWhite,
    hintText:
        '\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022',
    hintStyle:
        TextStyles.regularTextStyle(textColor: Color(0xFF6F757B), fontSize: 18),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
        borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
        borderRadius: BorderRadius.circular(12)));

final _expiryDateDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.pureWhite,
    hintText: 'MM/YY',
    hintStyle: TextStyles.regularTextStyle(textColor: Color(0xFF6F757B)),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
        borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
        borderRadius: BorderRadius.circular(12)));

final _cvcDecoration = InputDecoration(
    filled: true,
    hintText: '\u2022\u2022\u2022',
    hintStyle:
        TextStyles.regularTextStyle(textColor: Color(0xFF6F757B), fontSize: 18),
    fillColor: AppColors.pureWhite,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
        borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDADFE1), width: 1),
        borderRadius: BorderRadius.circular(12)));
