import 'package:bloc/bloc.dart';
import 'package:helpert_app/features/video/model/recommeded_question_model.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';
import 'package:meta/meta.dart';

part 'recommended_question_state.dart';

class RecommendedQuestionCubit extends Cubit<RecommendedQuestionState> {
  RecommendedQuestionCubit() : super(RecommendedQuestionStateInitial());

  Future<void> getRecommendedQuestionList({bool isFromHome = false}) async {
    try {
      emit(RecommendedQuestionLoading());
      List<RecommendedQuestionModel> result =
          await VideoRepo.instance.getRecommendedQuestionsApi();
     if (isFromHome) {
        emit(HomeQuestionsLoaded(recommended: result));
      } else {
        emit(RecommendedQuestionLoaded(recommended: result));
      }    } catch (e) {
      emit(RecommendedQuestionError(e.toString()));
    }
  }

  Future<void> getDataLists({bool isFromHome = false}) async {
    try {
      emit(RecommendedQuestionLoading());
      var result = await VideoRepo.instance.getAllListApi();
      if (isFromHome) {
        emit(HomeQuestionsLoaded(recommended: result));
      } else {
        emit(RecommendedQuestionLoaded(recommended: result));
      }
    } catch (e) {
      emit(RecommendedQuestionError(e.toString()));
    }
  }
}
