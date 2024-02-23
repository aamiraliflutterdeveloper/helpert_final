import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/auth/bloc/auth_bloc.dart';
import 'package:helpert_app/features/auth/bloc/auth_state.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../common_widgets/bottons/custom_elevated_button.dart';
import '../../../../common_widgets/components/custom_appbar.dart';
import '../../../../constants/app_colors.dart';
import '../../../../dashboard_screen.dart';
import '../../../video/repo/video_repo.dart';
import '../../widgets/interest_box_widget.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  bool loading = false;
  final List<int> storesItems = [];

  @override
  void initState() {
    super.initState();
    callApi();
  }

  void callApi() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    AuthRepo.instance.user.interestList =
        await VideoRepo.instance.allInterestApi();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: const CustomAppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: 'Select Your Interests',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 12),
                  Text(
                      "Let us know your expertise, so that we find right people & don’t worry, your data will be safe.",
                      style: TextStyles.regularTextStyle(
                          textColor: AppColors.moon, fontSize: 14)),
                  const SizedBox(height: 20),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runSpacing: 24,
                          spacing: 14,
                          children: List.generate(
                              AuthRepo.instance.user.interestList.length,
                              (index) {
                            return InterestsBoxWidget(
                              storesItems: storesItems,
                              title: AuthRepo.instance.user.interestList[index],
                              onTap: (value) {
                                setState(() {
                                  if (storesItems.contains(value)) {
                                    storesItems.remove(value);
                                  } else {
                                    storesItems.add(value);
                                  }
                                });
                              },
                            );
                          }),
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    BotToast.showLoading();
                  }
                  if (state is AuthLoaded) {
                    BotToast.closeAllLoading();
                    BotToast.showText(text: 'Register Successfully');
                    NavRouter.pushAndRemoveUntil(
                        context, const DashBoardScreen());
                  }
                  if (state is AuthError) {
                    BotToast.closeAllLoading();
                    BotToast.showText(text: state.error);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    onTap: () {
                      Map<String, dynamic> interestMap = {
                        'interest[]': storesItems
                      };
                      context.read<AuthBloc>().postUserInterest(interestMap);
                    },
                    disable: storesItems.isEmpty ? true : false,
                    title: 'Continue',
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
