import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_state.dart';
import 'package:products_store_bloc/feature/home/model/product.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is ProductErrorState) {
            return Center(child: Text(state.error));
          }
          else if(state is ProductLoadedState) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = Product.fromJson(state.products[index]);
                return ProductItem(product);
              },
            );
          }

          return const Center(child: Text('No products'));

        },
      ),
    );
  }
}
