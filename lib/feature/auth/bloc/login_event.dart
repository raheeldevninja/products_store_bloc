import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailChangedEvent extends LoginEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object?> get props => [];
}

class PasswordChangedEvent extends LoginEvent {

  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [];
}

class LoginSubmittedEvent extends LoginEvent {}