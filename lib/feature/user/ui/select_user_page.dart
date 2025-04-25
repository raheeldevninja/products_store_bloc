import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/enums/user_type.dart';
import 'package:products_store_bloc/core/ui/square_button.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/user/bloc/user_bloc.dart';
import 'package:products_store_bloc/feature/user/bloc/user_event.dart';
import 'package:products_store_bloc/feature/user/bloc/user_state.dart';

class SelectUserPage extends StatelessWidget {
  const SelectUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select User'),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if(state is UserSelected) {

            switch (state.userType) {
              case UserType.admin:
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                break;
              case UserType.user:
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                break;
            }
          }
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquareButton(
                text: 'Admin',
                size: 160,
                onPressed: () {
                  context.read<UserBloc>().add(SelectUser(UserType.admin));
                },
              ),
              const SizedBox(width: 20),
              SquareButton(
                text: 'User',
                size: 160,
                onPressed: () {
                  context.read<UserBloc>().add(SelectUser(UserType.user));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
