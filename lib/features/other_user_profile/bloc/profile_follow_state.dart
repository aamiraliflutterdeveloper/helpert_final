import 'package:equatable/equatable.dart';

abstract class ProfileFollowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends ProfileFollowState {}

class ProfileFollowLoading extends ProfileFollowState {}

class ProfileFollowLoaded extends ProfileFollowState {}

class ProfileFollowError extends ProfileFollowState {
  final String error;

  ProfileFollowError(this.error);
  @override
  List<Object?> get props => [error];
}
