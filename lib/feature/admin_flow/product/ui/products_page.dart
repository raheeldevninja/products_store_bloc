import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_event.dart';
import 'package:products_store_bloc/core/product/bloc/product_state.dart';
import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/core/ui/products_list.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  List<dynamic> products = [];

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
          if (state is SuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          else if(state is ProductLoadedState) {
            products = state.products;
          }
        },
        builder: (context, state) {

          return Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ProductsList(products),

                ],
              ),


              (state is LoadingState) ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
            ],
          );

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
