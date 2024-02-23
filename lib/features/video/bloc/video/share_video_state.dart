abstract class ShareVideoState {}

class InitialState extends ShareVideoState {}

class ShareVideoLoading extends ShareVideoState {}

class ShareVideoLoaded extends ShareVideoState {}

class ShareVideoError extends ShareVideoState {
  final String error;

  ShareVideoError(this.error);
}
