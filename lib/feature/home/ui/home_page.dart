import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/auth/ui/page/login_page.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_state.dart';
import 'package:products_store_bloc/feature/home/model/product.dart';

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

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            product.image,
                            height: 80.0,
                            width: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8.0),
                              // Category
                              Text(
                                product.category,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Price
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Rating
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16.0),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    product.rating.rate.toString(),
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '(${product.rating.count} reviews)',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No products'));

        },
      ),
    );
  }
}
