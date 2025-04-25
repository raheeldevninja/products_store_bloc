import 'package:products_store_bloc/core/product/model/product.dart';

class CartProduct {
  final Product product;
  final int quantity;

  CartProduct({
    required this.product,
    required this.quantity,
  });
}
