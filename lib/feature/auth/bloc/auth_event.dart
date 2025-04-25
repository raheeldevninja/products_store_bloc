import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmittedEvent extends AuthEvent {
  final String username;
  final String password;

  LoginSubmittedEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}


class RegisterSubmittedEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;

  RegisterSubmittedEvent(this.email, this.username, this.password);

  @override
  List<Object?> get props => [email, username, password];
}

class CheckLoginStatusEvent extends AuthEvent {}
