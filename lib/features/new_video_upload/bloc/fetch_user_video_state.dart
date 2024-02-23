import 'package:equatable/equatable.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';

abstract class FetchUserVideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends FetchUserVideoState {}

class FetchUserVideoLoading extends FetchUserVideoState {}

class FetchUserVideoLoaded extends FetchUserVideoState {
  final AllVideosModel currentUserVideos;
  FetchUserVideoLoaded({required this.currentUserVideos});
  @override
  List<Object?> get props => [currentUserVideos];
}

class FetchUserVideoError extends FetchUserVideoState {
  final String error;

  FetchUserVideoError(this.error);
  @override
  List<Object?> get props => [error];
}
