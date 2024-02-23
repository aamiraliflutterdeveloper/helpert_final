import 'package:equatable/equatable.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';

abstract class OtherProfileVideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends OtherProfileVideoState {}

class OtherProfileVideoLoading extends OtherProfileVideoState {}

class OtherProfileVideoLoaded extends OtherProfileVideoState {
  final AllVideosModel otherUserVideos;
  OtherProfileVideoLoaded({required this.otherUserVideos});
  @override
  List<Object?> get props => [otherUserVideos];
}

class OtherProfileVideoError extends OtherProfileVideoState {
  final String error;

  OtherProfileVideoError(this.error);
  @override
  List<Object?> get props => [error];
}
