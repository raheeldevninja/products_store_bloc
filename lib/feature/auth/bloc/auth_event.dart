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