import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_bloc.dart';
import 'package:products_store_bloc/feature/auth/repository/auth_repository.dart';
import 'package:products_store_bloc/feature/auth/service/auth_service.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';

class ProductsStoreApp extends StatelessWidget {
  const ProductsStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(AuthService.create()),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) => AuthBloc(context.read<AuthRepository>()),
            child: MaterialApp(
              title: 'Products Store',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const LoginPage(),
            ),
          );
        }
      ),
    );
  }
}
