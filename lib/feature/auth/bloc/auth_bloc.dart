import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_state.dart';
import 'package:products_store_bloc/feature/auth/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<RegisterSubmittedEvent>(_onRegisterSubmittedEvent);
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
  }

  void _onLoginSubmitted(LoginSubmittedEvent event, Emitter<AuthState> emit) async {

    final validationErrors = _validateInputs(event.username, event.password);

    if (validationErrors.isNotEmpty) {
      emit(AuthValidationError(
        usernameError: validationErrors['username'],
        passwordError: validationErrors['password'],
      ));

      // Stop further processing if validation fails
      return;
    }

    emit(AuthLoadingState());

    try{
      final response = await authRepository.login(event.username, event.password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', response['token']);

      emit(AuthSuccessState(response['token']));
    }
    catch(e) {
      emit(AuthFailureState(e.toString()));
    }

  }

  // Helper method for validating inputs
  Map<String, String?> _validateInputs(String username, String password, {String? email}) {
    final errors = <String, String?>{};

    // Validate username
    if (username.isEmpty) {
      errors['username'] = 'Username is required';
    }

    // Validate password
    if (password.isEmpty) {
      errors['password'] = 'Password is required';
    } else if (password.length < 6) {
      errors['password'] = 'Password should be at least 6 characters long';
    }


    // Validate email
    if (email != null && email.isEmpty) {
      errors['email'] = 'Email is required';
    }
    else if (email != null) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        errors['email'] = 'Please enter a valid email address';
      }
    }

    return errors;
  }

  _onRegisterSubmittedEvent(RegisterSubmittedEvent event, Emitter<AuthState> emit) async {

    final validationErrors = _validateInputs(
        email: event.email,
        event.username,
        event.password,
    );

    if (validationErrors.isNotEmpty) {
      emit(AuthValidationError(
        usernameError: validationErrors['username'],
        passwordError: validationErrors['password'],
        emailError: validationErrors['email'],
      ));

      // Stop further processing if validation fails
      return;
    }

    emit(AuthLoadingState());

    try{
      final response = await authRepository.register(event.email, event.username, event.password);
      emit(RegisterSuccessState(response['id']));
    }
    catch(e) {
      emit(AuthFailureState(e.toString()));
    }
  }

  Future<void> _onCheckLoginStatus(CheckLoginStatusEvent event, Emitter<AuthState> emit) async {

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final token = prefs.getString('token') ?? '';

    if (isLoggedIn) {
      emit(AuthSuccessState(token));
    } else {
      emit(AuthInitialState());
    }
  }

}