import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List products;
  ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}


class ProductSuccessState extends ProductState {
  final String message;
  ProductSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);

  @override
  List<Object?> get props => [error];
}