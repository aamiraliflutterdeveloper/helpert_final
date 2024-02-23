import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/extension.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/book_call/bloc/save_slot_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/save_slot_state.dart';
import 'package:helpert_app/features/book_call/screens/booking_congratulation_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../common_widgets/components/text_view.dart';
import '../../../utils/masked_textcontroller.dart';

class SubscribeToSpecialistScreen extends StatefulWidget {
  final String appointmentDescription;
  final int sessionRate;
  final int doctorId;
  final int slotId;
  final int dayId;
  final DateTime date;
  const SubscribeToSpecialistScreen(
      {Key? key,
      required this.sessionRate,
      required this.doctorId,
      required this.slotId,
      required this.dayId,
      required this.date,
      required this.appointmentDescription})
      : super(key: key);

  @override
  State<SubscribeToSpecialistScreen> createState() =>
      _SubscribeToSpecialistScreenState();
}

class _SubscribeToSpecialistScreenState
    extends State<SubscribeToSpecialistScreen> {
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '000');

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: 'Subscribe to Specialist',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${widget.sessionRate}',
                            style: TextStyles.mediumTextStyle(
                                fontSize: 44, textColor: AppColors.acmeBlue),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'SESSION ',
                                  style:
                                      TextStyles.mediumTextStyle(fontSize: 14),
                                ),
                                TextSpan(
                                  text: '\u2022',
                                  style: TextStyles.mediumTextStyle(
                                      fontSize: 14, textColor: AppColors.moon),
                                ),
                                TextSpan(
                                  text: ' RATE',
                                  style: TextStyles.mediumTextStyle(
                                      fontSize: 14, textColor: AppColors.moon),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'MESSAGING & VIDEOCALL',
                            style: TextStyles.boldTextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.silver,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Payment',
                      style: TextStyles.boldTextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    TextView(
                      'Card Number',
                      textStyle: TextStyles.mediumTextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
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
                        decoration: _decoration),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                'Expiry Date',
                                textStyle: TextStyles.mediumTextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: _expiryDateController,
                                autofillHints: const <String>[
                                  AutofillHints.creditCardExpirationDate
                                ],
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid date';
                                  }
                                  final DateTime now = DateTime.now();
                                  final List<String> date =
                                      value.split(RegExp(r'/'));
                                  final int month = int.parse(date.first);
                                  final int year = int.parse('20${date.last}');
                                  final DateTime cardDate =
                                      DateTime(year, month);

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
                                decoration: _decoration,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                'CVV',
                                textStyle: TextStyles.mediumTextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: _cvvCodeController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (val) {
                                  setState(() {});
                                },
                                decoration: _decoration,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            width: double.infinity,
            child: BlocConsumer<SaveSlotBloc, SaveSlotState>(
                listener: (context, state) {
              if (state is SaveSlotLoading) {
                BotToast.showLoading();
              } else if (state is SaveSlotError) {
                BotToast.closeAllLoading();
                BotToast.showText(text: state.error);
              } else if (state is SaveSlotLoaded) {
                BotToast.closeAllLoading();
                NavRouter.push(context, BookingCongratulationScreen());
              }
            }, builder: (context, state) {
              return CustomElevatedButton(
                title: state is SaveSlotError ? 'Try Again' : 'Next',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    context.read<SaveSlotBloc>().saveBookingSlot(
                        widget.appointmentDescription,
                        widget.doctorId,
                        widget.date.toString(),
                        widget.slotId,
                        int.parse(
                            _cardNumberController.text.replaceAll(' ', '')),
                        int.parse(_expiryDateController.text.substring(0, 2)),
                        2000 +
                            int.parse(_expiryDateController.text.lastChars(2)),
                        int.parse(_cvvCodeController.text),
                        'card',
                        widget.dayId);
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PayWithWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String image;
  final String? secondImage;
  final double height;
  final double paddingVertical;
  final double paddingRight;
  final double paddingHorizontal;
  const PayWithWidget({
    Key? key,
    this.isSelected = false,
    required this.title,
    required this.image,
    this.secondImage,
    this.height = 8,
    this.paddingVertical = 12,
    this.paddingRight = 30,
    this.paddingHorizontal = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: 16, top: 16, bottom: 16, right: paddingRight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pay with',
                style: TextStyles.mediumTextStyle(
                    fontSize: 12, textColor: AppColors.moon),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: TextStyles.semiBoldTextStyle(
                    fontSize: 14, textColor: AppColors.black),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  PayWithImageWidget(
                      paddingHorizontal: paddingHorizontal,
                      paddingVertical: paddingVertical,
                      image: image,
                      height: height),
                  if (secondImage != null)
                    SizedBox(
                      width: 8,
                    ),
                  if (secondImage != null)
                    PayWithImageWidget(
                        paddingHorizontal: paddingHorizontal,
                        paddingVertical: paddingVertical,
                        image: secondImage!,
                        height: height),
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: isSelected ? AppColors.acmeBlue : AppColors.pureWhite),
            boxShadow: [
              BoxShadow(
                color: AppColors.silver.withOpacity(.4),
                spreadRadius: 8,
                blurRadius: 8,
                offset: Offset(4, 8), // changes position of shadow
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 20,
            height: 20,
            child: isSelected
                ? Center(
                    child: Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ))
                : SizedBox(),
            decoration: BoxDecoration(
                color: isSelected ? AppColors.success : AppColors.snow,
                shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}

class PayWithImageWidget extends StatelessWidget {
  const PayWithImageWidget({
    Key? key,
    required this.paddingHorizontal,
    required this.paddingVertical,
    required this.image,
    required this.height,
  }) : super(key: key);

  final double paddingHorizontal;
  final double paddingVertical;
  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.silver)),
      child: Image.asset(
        image,
        width: 32,
        height: height,
      ),
    );
  }
}

final _decoration = InputDecoration(
    filled: true, fillColor: AppColors.snow, border: InputBorder.none);
