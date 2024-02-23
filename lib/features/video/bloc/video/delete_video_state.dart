abstract class DeleteVideoState {}

class InitialState extends DeleteVideoState {}

class DeleteVideoLoading extends DeleteVideoState {}

class DeleteVideoLoaded extends DeleteVideoState {}

class DeleteVideoError extends DeleteVideoState {
  final String error;

  DeleteVideoError(this.error);
}
