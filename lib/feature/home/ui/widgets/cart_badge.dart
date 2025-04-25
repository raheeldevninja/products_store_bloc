import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_state.dart';
import 'package:products_store_bloc/feature/cart/ui/cart_page.dart';

class CartBadge extends StatefulWidget {
  const CartBadge({super.key});

  @override
  State<CartBadge> createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {

  int? _lastCartCount;

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
