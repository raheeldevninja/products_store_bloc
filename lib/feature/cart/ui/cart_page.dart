import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_event.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_state.dart';
import 'package:products_store_bloc/feature/cart/model/single_cart_model.dart';
import 'package:products_store_bloc/feature/cart/ui/cart_products_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  SingleCartResponse? cartResponse;

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(GetSingleCartProducts(1));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if(state is CartErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          else if(state is CartLoadedState) {
            cartResponse = state.cart;
          }
        },
        builder: (context, state) {
          return Stack(
            children: [

              CartProductsPage(cartProducts: cartResponse?.cartProducts ?? []),

              (state is CartLoadingState) ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
            ],
          );

        },
      ),
    );
  }
}
