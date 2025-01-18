import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/login_bloc.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';

class ProductsStoreApp extends StatelessWidget {
  const ProductsStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (create) => LoginBloc(),
        child: const LoginPage(),
      ),
    );
  }
}
