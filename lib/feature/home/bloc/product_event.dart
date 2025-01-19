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
}