import 'package:products_store_bloc/feature/cart/model/cart_product.dart';

class UpdateCartModel {
  final int id;
  final int userId;
  final List<CartProduct> products;

  UpdateCartModel({
    required this.id,
    required this.userId,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products.map((p) => {
        ...p.product.toJson(),
        'quantity': p.quantity,
      }).toList(),
    };
  }
}
