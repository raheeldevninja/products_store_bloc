import 'package:equatable/equatable.dart';
import 'package:products_store_bloc/feature/home/model/product.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class CreateProduct extends ProductEvent {
  final Product product;
  CreateProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final Product product;
  UpdateProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final int productId;
  DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}

class GetCategories extends ProductEvent {}

class GetCategoryProducts extends ProductEvent {
  final String category;

  GetCategoryProducts(this.category);

  @override
  List<Object?> get props => [category];
}