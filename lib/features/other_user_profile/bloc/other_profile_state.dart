import 'package:helpert_app/features/auth/models/user_model.dart';

abstract class OtherProfileState {}

class InitialState extends OtherProfileState {}

class OtherProfileLoading extends OtherProfileState {}

class OtherProfileLoaded extends OtherProfileState {
  final UserModel user;
  OtherProfileLoaded({required this.user});
}

class OtherProfileError extends OtherProfileState {
  final String error;

  OtherProfileError(this.error);
}
