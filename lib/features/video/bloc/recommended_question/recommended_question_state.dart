part of 'recommended_question_cubit.dart';

@immutable
abstract class RecommendedQuestionState {}

class RecommendedQuestionStateInitial extends RecommendedQuestionState {}

class RecommendedQuestionLoading extends RecommendedQuestionState {}

class RecommendedQuestionLoaded extends RecommendedQuestionState {
  final dynamic recommended;

  RecommendedQuestionLoaded({required this.recommended});
}

class HomeQuestionsLoaded extends RecommendedQuestionState {
  final dynamic recommended;

  HomeQuestionsLoaded({required this.recommended});
}

class RecommendedQuestionError extends RecommendedQuestionState {
  final String error;

  RecommendedQuestionError(this.error);
}
