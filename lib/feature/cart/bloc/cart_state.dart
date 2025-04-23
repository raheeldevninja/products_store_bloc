import 'package:equatable/equatable.dart';
import 'package:products_store_bloc/feature/cart/model/cart_product.dart';

class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {

  final List<CartProduct> cartItems;

  CartLoadedState(this.cartItems);

  @override
  List<Object?> get props => [cartItems];

}

class CartErrorState extends CartState {
  final String message;

  CartErrorState(this.message);

  @override
  List<Object?> get props => [message];
}