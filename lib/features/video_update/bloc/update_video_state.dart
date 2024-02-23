abstract class UpdateVideoState {}

class InitialState extends UpdateVideoState {}

class UpdateVideoLoading extends UpdateVideoState {}

class UpdateVideoLoaded extends UpdateVideoState {}

class UpdateVideoError extends UpdateVideoState {
  final String error;

  UpdateVideoError(this.error);
}
