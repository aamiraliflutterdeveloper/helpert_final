abstract class AuthState {}

class InitialState extends AuthState {}

class AuthLoading extends AuthState {}

class SocialAuthLoading extends AuthState {}

class SocialError extends AuthState {
  final String error;

  SocialError(this.error);
}

class AuthLoaded extends AuthState {}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}
