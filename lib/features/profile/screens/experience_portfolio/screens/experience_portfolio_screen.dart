import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/app_colors.dart';

import '../../../../../common_widgets/bottons/elevated_button_without_icon.dart';
import '../../../../../common_widgets/components/custom_appbar.dart';
import '../../../../../constants/api_endpoints.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../core/models/api_response.dart';
import '../../../../../core/services/rest_api_service.dart';
import '../../../../../utils/nav_router.dart';
import '../../../../auth/screens/register/specialization_detail_screen.dart';
import '../../../../video/bloc/recommended_question/recommended_question_cubit.dart';
import '../../../../video/model/all_list_model.dart';
import '../../../bloc/profile_bloc.dart';
import '../widgets/expertise_portfolio_card.dart';

class ExperiencePortfolioScreen extends StatefulWidget {
  const ExperiencePortfolioScreen({Key? key}) : super(key: key);

  @override
  State<ExperiencePortfolioScreen> createState() =>
      _ExperiencePortfolioScreenState();
}

class _ExperiencePortfolioScreenState extends State<ExperiencePortfolioScreen> {
  AllListModel? allListModel;

  @override
  initState() {
    super.initState();
    getAllListApi();
  }

  bool isLoading = false;

  Future<AllListModel?> getAllListApi() async {
    isLoading = true;
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kAllListApi,
      isTokenRequired: true,
    );
    if (apiResponse.result == 'success') {
      allListModel = AllListModel.fromJson(apiResponse.data);
      isLoading = false;
      setState(() {});
    } else {
      throw apiResponse.message!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Experience Portfolio',
      ),
      body: isLoading == false
          ? SafeArea(
            top: false,
            bottom: true,
            child: Column(
                children: [
                  SizedBox(height: 15),
                  Align(
                      alignment: Alignment.center,
                      child: Text("Manage your Specialisation & work history.",
                          style: TextStyles.regularTextStyle(
                              fontSize: 14, textColor: AppColors.moon))),
                  SizedBox(height: 15),
                  Expanded(
                      child: ExpertisePortfolioCard(allListModel: allListModel!)),
                  Container(height: 10, color: AppColors.pureWhite),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocConsumer<RecommendedQuestionCubit,
                          RecommendedQuestionState>(
                        listener: (context, state) {
                          if (state is RecommendedQuestionLoading) {
                            BotToast.showLoading();
                          } else if (state is RecommendedQuestionError) {
                            BotToast.closeAllLoading();
                            BotToast.showText(text: state.error);
                          } else if (state is RecommendedQuestionLoaded) {
                            BotToast.closeAllLoading();
                            NavRouter.push(
                                context,
                                SpecializationDetailScreen(
                                  isFromSplash: false,
                                  allListModel: state.recommended,
                                )).then((value) {
                              // context.read<ProfileBloc>().profileFetched = false;
                              context
                                  .read<ProfileBloc>()
                                  .fetchProfile()
                                  .then((value) {
                                setState(() {});
                              });
                            });
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButtonWithoutIcon(
                            onPressed: () {
                              context
                                  .read<RecommendedQuestionCubit>()
                                  .getDataLists();
                            },
                            primaryColor: AppColors.snow,
                            borderColor: AppColors.snow,
                            textColor: AppColors.acmeBlue,
                            text: '+ Add New Work & Portfolios',
                          );
                        },
                      ),
                    ),
                  ),
                  Container(height: 10, color: AppColors.pureWhite),
                ],
              ),
          )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
