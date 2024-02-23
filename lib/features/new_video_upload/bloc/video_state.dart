import 'package:helpert_app/features/video/model/videos_model.dart';

abstract class VideoState {}

class InitialState extends VideoState {}

class VideoLoading extends VideoState {}

class VideoStatusState extends VideoState {
  final int sentStatus;
  final int receiveStatus;

  VideoStatusState({required this.sentStatus, required this.receiveStatus});
}

class VideoLoaded extends VideoState {}

class VideoError extends VideoState {
  final String error;

  VideoError(this.error);
}

class VideoLikedDisliked extends VideoState {
  final String message;

  VideoLikedDisliked({required this.message});
}

class AllVideosLoaded extends VideoState {
  final AllVideosModel allVideos;
  AllVideosLoaded({required this.allVideos});
}
