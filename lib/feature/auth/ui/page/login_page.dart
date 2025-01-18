import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_state.dart';
import 'package:products_store_bloc/feature/home/ui/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(text: 'mor_2314');
  final _passwordController = TextEditingController(text: '83r5^_');

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            //navigate to home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login Failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
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
                    onPressed: (state is AuthLoadingState)
                        ? null
                        : () {
                            final username = _usernameController.text.trim();
                            final password = _passwordController.text.trim();

                            loginBloc
                                .add(LoginSubmittedEvent(username, password));
                          },
                    child: (state is AuthLoadingState)
                        ? const CircularProgressIndicator(color: Colors.blue)
                        : const Text('Submit'),
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
