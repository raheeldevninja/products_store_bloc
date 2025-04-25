import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_event.dart';
import 'package:products_store_bloc/core/product/bloc/product_state.dart';
import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/core/ui/products_list.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_state.dart';
import 'package:products_store_bloc/feature/cart/ui/cart_page.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/categories_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product> products = [];
  List<String> categories = [];

  int? _lastCartCount;


  @override
  void initState() {
    super.initState();

    _getCategories();
  }

  _getCategories() {
    context.read<ProductBloc>().add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {

                int cartItemCount = _lastCartCount ?? 0;

                if (state is CartLoadedState) {
                  cartItemCount = state.cartItems.length;
                  _lastCartCount = cartItemCount; // Cache the latest cart count
                }

                return  Badge(
                  label: Text('$cartItemCount'),
                  child: const Icon(Icons.shopping_cart),
                );
              },
            ),
          ),
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
          else if(state is CategoryLoadedState) {
            categories = state.categories;
            categories.insert(0, 'All');

            //get all products
            context.read<ProductBloc>().add(LoadProducts());
          }
        },
        builder: (context, state) {

          return Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoriesList(categories),
                  ProductsList(products, productsPageContext: context),
                ],
              ),

              (state is LoadingState) ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
            ],
          );

        },
      ),
    );
  }
}
