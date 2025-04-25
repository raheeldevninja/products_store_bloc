import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_event.dart';
import 'package:products_store_bloc/core/product/bloc/product_state.dart';
import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/core/ui/products_list.dart';
import 'package:products_store_bloc/feature/admin_flow/product/ui/add_update_product_page.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    _getAllProducts();
  }

  _getAllProducts() {
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Page'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {

              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn');
              await prefs.remove('token');

              if(context.mounted) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }

            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if(state is SuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {

            final isLoading = state is LoadingState;
            final List<Product> products = state is ProductLoadedState ? state.products : [];

            return Stack(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductsList(productsPageContext: context, products),
                  ],
                ),

                if (isLoading)
                  const Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddUpdateProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
