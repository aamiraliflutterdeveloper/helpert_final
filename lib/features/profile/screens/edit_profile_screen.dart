import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/prefs.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/profile/screens/session_rate/screens/session_rate_screen.dart';

import '../../../common_widgets/components/custom_appbar.dart';
import '../../../common_widgets/custom_dialog.dart';
import '../../../constants/asset_paths.dart';
import '../../../utils/nav_router.dart';
import '../../../utils/shared_preference_manager.dart';
import '../../auth/repo/auth_repo.dart';
import '../../auth/screens/login/signin_screen.dart';
import '../../notifications/bloc/notification_bloc.dart';
import '../../reusable_video_list/app_data.dart';
import '../bloc/profile_bloc.dart';
import 'account/screens/account_screen.dart';
import 'experience_portfolio/screens/experience_portfolio_screen.dart';
import 'help_center_screen.dart';
import 'my_earning/screens/my_earning_screen.dart';
import 'payment_settings/screens/payment_settings_screen.dart';
import 'privacy_policy_screen.dart';
import 'report_problem_screen.dart';
import 'schedule/screens/my_schedule_screen.dart';
import 'terms_and_conditions_screen.dart';
import 'widgets/edit_profile_tile.dart';

class EditProfileScreen extends StatefulWidget {
  final int? notificationId;
  final bool addPaymentNotification;
  final bool myScheduleNotification;
  final int? read;

  const EditProfileScreen(
      {Key? key,
      this.notificationId,
      this.read,
      this.addPaymentNotification = false,
      this.myScheduleNotification = false})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  final addPaymentKey = GlobalKey();
  final myScheduleKey = GlobalKey();

  @override
  void initState() {
    if (widget.addPaymentNotification || widget.myScheduleNotification) {
      Future.delayed(Duration.zero, () {
        if (widget.addPaymentNotification) {
          if (mounted && addPaymentKey.currentContext != null) {
            Scrollable.ensureVisible(addPaymentKey.currentContext!);
          }
        } else {
          if (mounted && myScheduleKey.currentContext != null) {
            Scrollable.ensureVisible(myScheduleKey.currentContext!);
          }
        }
      });
      animation = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800),
      );
      _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animation.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animation.forward();
        }
      });
      animation.forward();
    }
    if (widget.read == 0 && widget.notificationId != null) {
      debugPrint('${widget.read}');
      debugPrint('${widget.notificationId}');
      Future.wait([
        context
            .read<NotificationBloc>()
            .readNotification(widget.notificationId!),
        context.read<NotificationBloc>().updateNotificationCountApi(),
      ]);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.addPaymentNotification || widget.myScheduleNotification) {
      animation.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDoctor = AuthRepo.instance.getUserRole() == '3';
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings and privacy',
        hasElevation: true,
        onBackIconPress: () {
          NavRouter.pop(context, true);
        },
      ),
      body: WillPopScope(
        onWillPop: () {
          NavRouter.pop(context, true);
          return Future.value(true);
        },
        child: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Account section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextView(
                          'ACCOUNT',
                          textStyle: TextStyles.regularTextStyle(
                            fontSize: 13,
                            textColor: Color(0xFF86878B),
                          ),
                        ),
                      ),
                      EditProfileTile(
                          title: 'Manage my account',
                          subtitle: 'Edit your personal info',
                          icon: account_icon,
                          onTap: () {
                            NavRouter.push(context, AccountScreen());
                          }),
                      Stack(
                        children: [
                          if (widget.myScheduleNotification)
                            Center(
                              child: FadeTransition(
                                opacity: _fadeInFadeOut,
                                child: Container(
                                  margin: EdgeInsets.only(top: 4),
                                  color: AppColors.acmeBlue.withOpacity(.4),
                                  width: double.infinity,
                                  height: 60,
                                ),
                              ),
                            ),
                          EditProfileTile(
                              key: myScheduleKey,
                              title: 'My schedule',
                              subtitle: 'Show your availability time',
                              icon: schedule_icon,
                              onTap: () {
                                if (isDoctor) {
                                  NavRouter.push(context, MyScheduleScreen());
                                } else {
                                  NavRouter.push(
                                      context, ExperiencePortfolioScreen());
                                }
                              }),
                        ],
                      ),
                      EditProfileTile(
                          title: 'Experience & Portfolios',
                          subtitle: 'Manage Specialisation & work history',
                          icon: portfolio_icon,
                          onTap: () {
                            NavRouter.push(
                                context, ExperiencePortfolioScreen());
                          }),
                      EditProfileTile(
                          title: 'Set session price',
                          subtitle: 'Per consultation charges',
                          icon: ic_wallet,
                          onTap: () {
                            if (isDoctor) {
                              NavRouter.push(context, SessionRateScreen())
                                  .then((value) {
                                if (value == true) {
                                  context
                                      .read<ProfileBloc>()
                                      .fetchProfile(loading: false);
                                }
                              });
                            } else {
                              NavRouter.push(
                                  context, ExperiencePortfolioScreen());
                            }
                          }),
                      Stack(
                        children: [
                          if (widget.addPaymentNotification)
                            Center(
                              child: FadeTransition(
                                opacity: _fadeInFadeOut,
                                child: Container(
                                  margin: EdgeInsets.only(top: 4),
                                  color: AppColors.acmeBlue.withOpacity(.4),
                                  width: double.infinity,
                                  height: 60,
                                ),
                              ),
                            ),
                          EditProfileTile(
                              key: addPaymentKey,
                              title: 'Add payment method',
                              subtitle: 'Add payment method by tap',
                              icon: payment_icon,
                              onTap: () {
                                if (isDoctor) {
                                  NavRouter.push(
                                      context, PaymentSettingScreen());
                                } else {
                                  NavRouter.push(
                                      context, ExperiencePortfolioScreen());
                                }
                              }),
                        ],
                      ),
                      EditProfileTile(
                        title: 'My earnings',
                        subtitle: 'Your total earnings',
                        icon: earnings_icon,
                        onTap: () {
                          NavRouter.push(context, MyEarningScreen());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                          color: AppColors.silver,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      /// General section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextView(
                          'GENERAL',
                          textStyle: TextStyles.regularTextStyle(
                            fontSize: 13,
                            textColor: Color(0xFF86878B),
                          ),
                        ),
                      ),
                      EditProfileTile(
                        title: 'Push notifications',
                        subtitle: 'Your total earnings',
                        icon: ic_bell,
                        onTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                          color: AppColors.silver,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      /// Support section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextView(
                          'SUPPORT',
                          textStyle: TextStyles.regularTextStyle(
                            fontSize: 13,
                            textColor: Color(0xFF86878B),
                          ),
                        ),
                      ),
                      EditProfileTile(
                        title: 'Report a problem',
                        subtitle: 'Your total earnings',
                        icon: ic_rp,
                        onTap: () {
                          NavRouter.push(context, ReportProblemScreen());
                        },
                      ),
                      EditProfileTile(
                        title: 'Help Center',
                        subtitle: 'Your total earnings',
                        icon: ic_help_center,
                        onTap: () {
                          NavRouter.push(context, HelpCenterScreen());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                          color: AppColors.silver,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      /// About section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextView(
                          'ABOUT',
                          textStyle: TextStyles.regularTextStyle(
                            fontSize: 13,
                            textColor: Color(0xFF86878B),
                          ),
                        ),
                      ),
                      EditProfileTile(
                        title: 'Terms of Service',
                        subtitle: 'Your total earnings',
                        icon: ic_terms,
                        onTap: () {
                          NavRouter.push(context, TermsOfServiceScreen());
                        },
                      ),
                      EditProfileTile(
                        title: 'Privacy Policy',
                        subtitle: 'Your total earnings',
                        icon: ic_privacy,
                        onTap: () {
                          NavRouter.push(context, PrivacyPolicyScreen());
                        },
                      ),
                      EditProfileTile(
                        title: 'Log out',
                        subtitle: 'Your total earnings',
                        icon: ic_logout,
                        onTap: () {
                          CustomDialogs.showLogoutDialog(
                            context,
                            onYesSelection: () async {
                              NavRouter.pop(context);
                              await PreferenceManager.instance.clear();
                              PreferenceManager.instance
                                  .setString(Prefs.TOKEN, '');
                              await PreferenceManager.instance
                                  .setBool(Prefs.ONBOARDING_SEEN, true);
                              Appdata.detailsSubmitted = false;
                              Appdata.chargesEnabled = false;
                              NavRouter.pushAndRemoveUntil(
                                  context, LoginScreen());
                            },
                            onNoSelection: () {
                              NavRouter.pop(context);
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                          color: AppColors.silver,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Transform.translate(
                          offset: Offset(0, 6),
                          child: Text(
                            'v1.0.0',
                            textAlign: TextAlign.center,
                            style: TextStyles.regularTextStyle(
                              fontSize: 15,
                              textColor: Color(0xFF86878B),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
