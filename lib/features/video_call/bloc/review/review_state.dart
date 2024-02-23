abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoadingState extends ReviewState {}

class ReviewLoadedState extends ReviewState {}

class ReviewErrorState extends ReviewState {
  final String message;
  ReviewErrorState(this.message);
}
