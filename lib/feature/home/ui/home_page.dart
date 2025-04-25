import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_event.dart';
import 'package:products_store_bloc/core/product/bloc/product_state.dart';
import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/core/ui/products_list.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_bloc.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_event.dart';
import 'package:products_store_bloc/feature/auth/bloc/auth_state.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/cart_badge.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/categories_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product> products = [];
  List<String> categories = [];

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

    return BlocConsumer<ProductBloc, ProductState>(
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
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {

            if(state is LoggedOut) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                const CartBadge(),
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
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
          ),
        );
      },

    );
  }
}
