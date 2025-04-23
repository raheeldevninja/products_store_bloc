import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_state.dart';
import 'package:products_store_bloc/feature/home/ui/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController(text: 'abc@gmail.com');
  final _usernameController = TextEditingController(text: 'raheelk');
  final _passwordController = TextEditingController(text: '12345678');

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            //navigate to home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Register Failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          final emailError =
          state is AuthValidationError ? state.emailError : null;
          final usernameError =
              state is AuthValidationError ? state.usernameError : null;
          final passwordError =
              state is AuthValidationError ? state.passwordError : null;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Email",
                      errorText: emailError,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Username",
                      errorText: usernameError,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: passwordError,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                    ),
                    onPressed: (state is AuthLoadingState)
                        ? null
                        : () {
                            final email = _emailController.text.trim();
                            final username = _usernameController.text.trim();
                            final password = _passwordController.text.trim();

                            loginBloc
                                .add(RegisterSubmittedEvent(email, username, password));
                          },
                    child: (state is AuthLoadingState)
                        ? const CircularProgressIndicator(color: Colors.blue)
                        : const Text('Submit'),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.pop(context);
                            },
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
