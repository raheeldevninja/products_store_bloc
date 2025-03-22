import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_event.dart';
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
          } else if (state is ProductErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is ProductLoadedState) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final product = Product(
            title: 'Laptop',
            price: 1000,
            description: 'New laptop',
            image: 'https://i.pravatar.cc',
            category: 'Electronic',
          );

          context.read<ProductBloc>().add(CreateProduct(product));

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
