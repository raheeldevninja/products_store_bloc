import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/service/chopper_client.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_bloc.dart';
import 'package:products_store_bloc/feature/auth/repository/auth_repository.dart';
import 'package:products_store_bloc/feature/auth/service/auth_service.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_bloc.dart';
import 'package:products_store_bloc/feature/cart/repository/cart_repository.dart';
import 'package:products_store_bloc/feature/cart/service/cart_service.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_event.dart';
import 'package:products_store_bloc/feature/home/repository/product_repository.dart';
import 'package:products_store_bloc/feature/home/service/product_service.dart';

class ProductsStoreApp extends StatelessWidget {
  const ProductsStoreApp({super.key});

  @override
  Widget build(BuildContext context) {

    final chopperClient = createChopperClient();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository(chopperClient.getService<AuthService>())),
        RepositoryProvider(create: (_) => ProductRepository(chopperClient.getService<ProductService>())),
        RepositoryProvider(create: (_) => CartRepository(chopperClient.getService<CartService>())),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => AuthBloc(context.read<AuthRepository>())),
              BlocProvider(create: (_) => ProductBloc(context.read<ProductRepository>())..add(LoadProducts())),
              BlocProvider(create: (_) => CartBloc(context.read<CartRepository>())),
            ],
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
