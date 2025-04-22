import 'package:equatable/equatable.dart';
import 'package:products_store_bloc/feature/home/model/product.dart';

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
  final Product product;

  AddProductInCart(this.product);

  @override
  List<Object?> get props => [product];
}