import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/admin_flow/product/ui/products_page.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_state.dart';
import 'package:products_store_bloc/feature/auth/ui/page/register_page.dart';
import 'package:products_store_bloc/feature/home/ui/home_page.dart';
import 'package:products_store_bloc/feature/user/bloc/user_bloc.dart';
import 'package:products_store_bloc/feature/user/bloc/user_state.dart';

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

    final userType = context.select<UserBloc, String>((bloc) {
      final state = bloc.state;
      if (state is UserSelected) {
        return state.userType.label;
      }
      return '';
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('$userType Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {

            if(userType == 'Admin') {
              //navigate to admin products screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductsPage(),
                ),
              );
            }
            else if(userType == 'User') {
              //navigate to user home screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }


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
                            final username = _usernameController.text.trim();
                            final password = _passwordController.text.trim();

                            loginBloc
                                .add(LoginSubmittedEvent(username, password));
                          },
                    child: (state is AuthLoadingState)
                        ? const CircularProgressIndicator(color: Colors.blue)
                        : const Text('Login'),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
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
