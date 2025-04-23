import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_event.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_state.dart';
import 'package:products_store_bloc/feature/cart/ui/cart_items.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartInitialState) {
          context.read<CartBloc>().add(GetSingleCartProducts(1));
        }
      },
      child: Scaffold(
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
          },
          builder: (context, state) {
            if (state is CartLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoadedState) {
              return CartItems(state.cartItems);
            } else {
              return const SizedBox();
            }

          },
        ),
      ),
    );
  }
}
