import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/features/video/model/all_list_model.dart';

import '../../../../../common_widgets/bottons/elevated_button_without_icon.dart';
import '../../../../../common_widgets/components/text_view.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../utils/nav_router.dart';
import '../../../../auth/repo/auth_repo.dart';
import '../../../bloc/profile_bloc.dart';
import '../../edit_profile_specialization.dart';

class ExpertisePortfolioCard extends StatefulWidget {
  final AllListModel? allListModel;
  const ExpertisePortfolioCard({
    this.allListModel,
    Key? key,
  }) : super(key: key);

  @override
  State<ExpertisePortfolioCard> createState() => _ExpertisePortfolioCardState();
}

class _ExpertisePortfolioCardState extends State<ExpertisePortfolioCard> {
  /// Needs Comments ...

  DateTime currentDate = DateTime.now();
  // final String end_date = '${AuthRepo.instance.user.end_date}';
  String? dateDifference;

  bool isDoctor = AuthRepo.instance.getUserRole() == '3';

  vehicleAge(DateTime currentDate, DateTime dt) {
    Duration parse = currentDate.difference(dt).abs();
    dateDifference =
        "${parse.inDays ~/ 360} Years ${((parse.inDays % 360) ~/ 30)} Month";
    return "${parse.inDays ~/ 360} Years ${((parse.inDays % 360) ~/ 30)} Month";
  }

  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: AuthRepo.instance.user.userSecondDetailLIst.length,
        itemBuilder: (context, index) {
          if (isDoctor == true) {
            DateTime dt = DateTime.parse(AuthRepo
                .instance.user.userSecondDetailLIst[index].joining_date);
            vehicleAge(currentDate, dt);
          }
          return isDoctor
              ? SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Experience",
                                    style: TextStyles.boldTextStyle(),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: ElevatedButtonWithoutIcon(
                                      height: 34,
                                      onPressed: () {
                                        currentIndex = index;
                                        NavRouter.push(
                                            context,
                                            EditProfileSpecialization(
                                              isFromExperiencePortfolio: true,
                                              portfolioID: AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[
                                                      currentIndex]
                                                  .id,
                                              specializationId: AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[
                                                      currentIndex]
                                                  .specializationId!,
                                              iAm_id: AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[
                                                      currentIndex]
                                                  .iam!
                                                  .id,
                                              company_id: AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[
                                                      currentIndex]
                                                  .companys!
                                                  .id,
                                              allListModel: widget.allListModel,
                                              iam: AuthRepo
                                                          .instance
                                                          .user
                                                          .userSecondDetailLIst[
                                                              currentIndex]
                                                          .expertise !=
                                                      null
                                                  ? '${AuthRepo.instance.user.userSecondDetailLIst[currentIndex].expertise}'
                                                  : AuthRepo.instance.user.userSecondDetailLIst[currentIndex].iam!.name,
                                              specialization: AuthRepo
                                                          .instance
                                                          .user
                                                          .userSecondDetailLIst[
                                                              currentIndex]
                                                          .specialization !=
                                                      null
                                                  ? '${AuthRepo.instance.user.userSecondDetailLIst[currentIndex].specialization}'
                                                  : AuthRepo.instance.user.userSecondDetailLIst[currentIndex].specializations!.name,
                                              company: AuthRepo
                                                          .instance
                                                          .user
                                                          .userSecondDetailLIst[
                                                              currentIndex]
                                                          .company !=
                                                      null
                                                  ? '${AuthRepo.instance.user.userSecondDetailLIst[currentIndex].company}'
                                                  : AuthRepo.instance.user.userSecondDetailLIst[currentIndex].companys!.name,
                                              location:
                                                  '${AuthRepo.instance.user.userSecondDetailLIst[currentIndex].location}',
                                              start_date:
                                                  AuthRepo.instance.user.userSecondDetailLIst[currentIndex].joining_date,
                                              end_date: AuthRepo
                                                      .instance
                                                      .user
                                                      .userSecondDetailLIst[
                                                          currentIndex]
                                                      .end_date
                                                      .isNotEmpty
                                                  ? AuthRepo.instance.user.userSecondDetailLIst[currentIndex].end_date
                                                  : null,
                                              isWorking: AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[
                                                      currentIndex]
                                                  .currentlyWorking!,
                                              description: AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[
                                                      currentIndex]
                                                  .description!,
                                            )).then((value) {
                                          // context.read<ProfileBloc>().profileFetched = false;
                                          context
                                              .read<ProfileBloc>()
                                              .fetchProfile()
                                              .then((value) {
                                            setState(() {});
                                          });
                                        });
                                      },
                                      text: 'Edit',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Company",
                                      style: TextStyles.regularTextStyle(
                                          fontSize: 12,
                                          textColor: AppColors.moon),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[index]
                                                  .company !=
                                              null
                                          ? '${AuthRepo.instance.user.userSecondDetailLIst[index].company}'
                                          : AuthRepo.instance.user.userSecondDetailLIst[index].companys!.name,
                                      style: TextStyles.regularTextStyle(),
                                    ),
                                    SizedBox(height: 5),
                                    TextView(
                                      AuthRepo
                                              .instance
                                              .user
                                              .userSecondDetailLIst[index]
                                              .end_date
                                              .isEmpty
                                          ? '${AuthRepo.instance.user.userSecondDetailLIst[index].joining_date} - Present • $dateDifference'
                                          : '${AuthRepo.instance.user.start_date} - ${AuthRepo.instance.user.userSecondDetailLIst[index].end_date}',
                                      textStyle: TextStyles.regularTextStyle(
                                          textColor: AppColors.moon,
                                          fontSize: 13),
                                    ),
                                    // TextView(
                                    //   end_date.isEmpty
                                    //       ? '${AuthRepo.instance.user.start_date} - Present • '
                                    //       : '${AuthRepo.instance.user.start_date} - $end_date',
                                    //   textStyle: TextStyles.regularTextStyle(
                                    //       textColor: AppColors.moon, fontSize: 13),
                                    // ),
                                    SizedBox(height: 10),
                                    Text(
                                      "I am",
                                      style: TextStyles.regularTextStyle(
                                          fontSize: 12,
                                          textColor: AppColors.moon),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[index]
                                                  .expertise !=
                                              null
                                          ? '${AuthRepo.instance.user.userSecondDetailLIst[index].expertise}'
                                          : AuthRepo.instance.user.userSecondDetailLIst[index].iam!.name,
                                      style: TextStyles.regularTextStyle(),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Specialised in",
                                      style: TextStyles.regularTextStyle(
                                          fontSize: 12,
                                          textColor: AppColors.moon),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AuthRepo
                                                  .instance
                                                  .user
                                                  .userSecondDetailLIst[index]
                                                  .specialization !=
                                              null
                                          ? '${AuthRepo.instance.user.userSecondDetailLIst[index].specialization}'
                                          : AuthRepo.instance.user.userSecondDetailLIst[index].specializations!.name,
                                      style: TextStyles.regularTextStyle(),
                                    ),
                                    SizedBox(height: 10),
                                    Text("Location",
                                        style: TextStyles.regularTextStyle(
                                            fontSize: 12,
                                            textColor: AppColors.moon)),
                                    SizedBox(height: 5),
                                    TextView(
                                      '${AuthRepo.instance.user.userSecondDetailLIst[index].location}',
                                      textStyle: TextStyles.regularTextStyle(),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Your Expertise",
                                      style: TextStyles.regularTextStyle(
                                          fontSize: 12,
                                          textColor: AppColors.moon),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${AuthRepo.instance.user.userSecondDetailLIst[index].description}',
                                      style: TextStyles.regularTextStyle(
                                          fontSize: 13.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height - 180,
                  child: Center(child: Text("No data found")));
        });
  }
}
