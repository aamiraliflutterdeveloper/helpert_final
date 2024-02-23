import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/profile/bloc/profile_bloc.dart';
import 'package:helpert_app/features/profile/bloc/profile_state.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../../common_widgets/bottons/custom_elevated_button.dart';
import '../../../../../common_widgets/components/custom_appbar.dart';
import '../../../../../constants/app_colors.dart';

class SessionRateScreen extends StatefulWidget {
  const SessionRateScreen({Key? key}) : super(key: key);

  @override
  State<SessionRateScreen> createState() => _SessionRateScreenState();
}

class _SessionRateScreenState extends State<SessionRateScreen> {
  bool disable = true;
  final _priceController = TextEditingController();

  @override
  void initState() {
    _priceController.text = AuthRepo.instance.user.sessionRate != null
        ? AuthRepo.instance.user.sessionRate.toString()
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        appBar: const CustomAppBar(
          title: 'Set Your Price',
        ),
        body: SafeArea(
          bottom: true,
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextFieldWithCenterText(
                        controller: _priceController,
                        onChanged: (value) {
                          if (_priceController.text.isNotEmpty) {
                            disable = false;
                          } else {
                            disable = true;
                          }
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20),
                      SessionRateText(),
                    ],
                  ),
                ),
                Text(
                  "Minimum price \$5 to maximum \$100",
                  style: TextStyles.mediumTextStyle(
                      textColor: AppColors.moon, fontSize: 14),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                    if (state is ProfileLoading) {
                      BotToast.showLoading();
                    } else if (state is ProfileError) {
                      BotToast.closeAllLoading();
                      BotToast.showText(text: state.error);
                    } else if (state is ProfileLoaded) {
                      BotToast.closeAllLoading();
                      NavRouter.pop(context, true);
                    }
                  }, builder: (context, state) {
                    return CustomElevatedButton(
                      disable: disable,
                      title: 'Save',
                      onTap: () {
                        if (int.parse(_priceController.text
                                    .replaceAll('\$', '')) <
                                5 ||
                            int.parse(_priceController.text
                                    .replaceAll('\$', '')) >
                                100) {
                          BotToast.showText(
                              text: 'Minimum price \$5 to maximum \$100');
                        } else {
                          context.read<ProfileBloc>().setSessionRate(int.parse(
                              _priceController.text.replaceAll('\$', '')));
                        }
                      },
                    );
                  }),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SessionRateText extends StatelessWidget {
  const SessionRateText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Session rate',
        style: TextStyles.mediumTextStyle(
            fontSize: 14, textColor: AppColors.black),
        children: <TextSpan>[
          TextSpan(
            text: '. Per 30 minutes Appointments',
            style: TextStyles.mediumTextStyle(
                fontSize: 14, textColor: AppColors.moon),
          ),
        ],
      ),
    );
  }
}

class TextFieldWithCenterText extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const TextFieldWithCenterText({
    this.controller,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 110),
      child: Row(
        children: [
          TextView(
            '\$',
            textStyle: TextStyles.mediumTextStyle(
              fontSize: 36,
              textColor: AppColors.acmeBlue,
            ),
          ),
          Flexible(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: Colors.black26,
              cursorWidth: 3,
              style: TextStyles.mediumTextStyle(
                fontSize: 36,
                textColor: AppColors.acmeBlue,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
              ],
              textAlign: TextAlign.center,
              autofocus: false,
              decoration: InputDecoration(
                hintText: '2',
                isDense: true,
                hintStyle: TextStyles.mediumTextStyle(
                    fontSize: 36, textColor: AppColors.silver),
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black12,
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black12,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black12,
                )),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black12,
                )),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black12,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
