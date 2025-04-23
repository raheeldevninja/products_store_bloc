import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final String? emailError;
  final String? usernameError;
  final String? passwordError;

  const AuthState({this.emailError, this.usernameError, this.passwordError});

  @override
  List<Object?> get props => [usernameError, passwordError];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String token;

  const AuthSuccessState(this.token);

  @override
  List<Object?> get props => [token];
}

class RegisterSuccessState extends AuthState {
  final int id;

  const RegisterSuccessState(this.id);

  @override
  List<Object?> get props => [id];
}

class AuthFailureState extends AuthState {
  final String error;

  const AuthFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthValidationError extends AuthState {
  const AuthValidationError({super.emailError, super.usernameError, super.passwordError});
}
