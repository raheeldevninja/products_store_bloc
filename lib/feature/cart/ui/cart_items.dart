import 'package:flutter/material.dart';
import 'package:products_store_bloc/feature/cart/model/cart_product.dart';
import 'package:products_store_bloc/feature/cart/ui/cart_product_item.dart';

class CartItems extends StatelessWidget {
  final List<CartProduct> items;

  const CartItems(
    this.items, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty ? const Center(child: Text('No items in cart'),)  :
    ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return CartProductItem(item);
      },
    );
  }
}
