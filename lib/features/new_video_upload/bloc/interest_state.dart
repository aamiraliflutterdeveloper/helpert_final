abstract class InterestState {}

class InitialState extends InterestState {}

class InterestError extends InterestState {
  final String error;

  InterestError(this.error);
}
