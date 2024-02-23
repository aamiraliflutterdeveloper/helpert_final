abstract class VideoViewState {}

class InitialState extends VideoViewState {}

class VideoViewLoading extends VideoViewState {}

class VideoViewLoaded extends VideoViewState {
  VideoViewLoaded();
}

class VideoViewError extends VideoViewState {
  final String error;

  VideoViewError(this.error);
}
