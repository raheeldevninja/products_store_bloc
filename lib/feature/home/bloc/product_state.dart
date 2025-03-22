import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class LoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List products;
  ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}


class SuccessState extends ProductState {
  final String message;
  SuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ErrorState extends ProductState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CategoryLoadedState extends ProductState {
  final List categories;

  CategoryLoadedState(this.categories);

  @override
  List<Object?> get props => [categories];
}