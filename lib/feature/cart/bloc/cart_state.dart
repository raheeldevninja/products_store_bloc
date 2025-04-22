import 'package:equatable/equatable.dart';
import 'package:products_store_bloc/feature/cart/model/single_cart_model.dart';

class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {

  final SingleCartResponse cart;

  CartLoadedState(this.cart);

  @override
  List<Object?> get props => [cart];

}

class CartErrorState extends CartState {
  final String message;

  CartErrorState(this.message);

  @override
  List<Object?> get props => [message];
}