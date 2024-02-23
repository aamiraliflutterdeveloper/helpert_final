import '../../model/videos_model.dart';

abstract class FetchAllVideoState {}

class InitialState extends FetchAllVideoState {}

class FetchAllVideoLoading extends FetchAllVideoState {}

class FetchAllVideoLoaded extends FetchAllVideoState {
  final AllVideosModel allVideos;
  FetchAllVideoLoaded({required this.allVideos});
}

class FetchAllVideoLinkLoaded extends FetchAllVideoState {
  final AllVideosModel allVideos;
  FetchAllVideoLinkLoaded({required this.allVideos});
}

class FetchAllVideoError extends FetchAllVideoState {
  final String error;

  FetchAllVideoError(this.error);
}
