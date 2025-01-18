import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_state.dart';
import 'package:products_store_bloc/feature/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
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
      emit(AuthSuccessState(response['token']));
    }
    catch(e) {
      emit(AuthFailureState(e.toString()));
    }

  }

  // Helper method for validating inputs
  Map<String, String?> _validateInputs(String username, String password) {
    final errors = <String, String?>{};

    // Validate email
    if (username.isEmpty) {
      errors['username'] = 'Username is required';
    }

    // Validate password
    if (password.isEmpty) {
      errors['password'] = 'Password is required';
    } else if (password.length < 6) {
      errors['password'] = 'Password should be at least 6 characters long';
    }

    return errors;
  }

}