import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/login_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/login_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextFormField(
                    onChanged: (email) => loginBloc.add(EmailChangedEvent(email)),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      errorText: state.isEmailValid ? null : 'Invalid Email',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextFormField(
                    onChanged: (password) => loginBloc.add(PasswordChangedEvent(password)),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: state.isPasswordValid ? null : 'Invalid password',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if(state.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Successful!")),
                    );
                  }

                  if(state.isFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login failed!")),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isSubmitting ? null : () => loginBloc.add(LoginSubmittedEvent()),
                    child: state.isSubmitting ? const CircularProgressIndicator(color: Colors.blue) : const Text('Submit'),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
