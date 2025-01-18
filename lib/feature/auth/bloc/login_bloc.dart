import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/login_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginState.initial()) {

    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChangedEvent event, Emitter<LoginState> emit) {
    final isEmailValid = _validateEmail(event.email);
    emit(state.copyWith(email: event.email, isEmailValid: isEmailValid, isSuccess: false));
  }

  void _onPasswordChanged(PasswordChangedEvent event, Emitter<LoginState> emit) {
    final isPasswordValid = _validatePassword(event.password);
    emit(state.copyWith(password: event.password, isPasswordValid: isPasswordValid, isSuccess: false));
  }

  void _onLoginSubmitted(LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    if(!state.isEmailValid || !state.isPasswordValid) {
      return;
    }

    emit(state.copyWith(isSubmitting: true, isSuccess: false));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isSubmitting: false, isSuccess: true));

  }

  bool _validateEmail(String email) {

    if(email.isEmpty) {
      return false;
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {

    if(password.isEmpty) {
      return false;
    }

    return password.length >= 6;
  }

}