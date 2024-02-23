abstract class EditProfileSpecializationState {}

class InitialState extends EditProfileSpecializationState {}

class UpdateSpecializationLoading extends EditProfileSpecializationState {}

class UpdateSpecializationLoaded extends EditProfileSpecializationState {}

class UpdateSpecializationError extends EditProfileSpecializationState {
  final String error;
  UpdateSpecializationError(this.error);
}
