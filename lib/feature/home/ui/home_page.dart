import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_event.dart';
import 'package:products_store_bloc/feature/home/bloc/product_state.dart';
import 'package:products_store_bloc/feature/home/model/product.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/categories_list.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/products_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> products = [];
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    context.read<ProductBloc>().add(GetCategories());

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
          }
        },
        builder: (context, state) {

          return Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CategoriesList(categories),
                  const SizedBox(height: 10),
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
