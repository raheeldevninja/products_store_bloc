import 'package:equatable/equatable.dart';
import 'package:products_store_bloc/feature/cart/model/update_cart_model.dart';

class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSingleCartProducts extends CartEvent {
  final int cartId;

  GetSingleCartProducts(this.cartId);

  @override
  List<Object?> get props => [cartId];
}

class AddProductInCart extends CartEvent {
  final int id;
  final UpdateCartModel payload;

  AddProductInCart(this.id, this.payload);

  @override
  List<Object?> get props => [id, payload];
}

class RemoveProductFromCart extends CartEvent {
  final int cartId;
  final int productId;

  RemoveProductFromCart(this.cartId, this.productId);
}