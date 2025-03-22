import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_event.dart';
import 'package:products_store_bloc/feature/home/bloc/product_state.dart';
import 'package:products_store_bloc/feature/home/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitialState()) {
    on<LoadProducts>(_onLoadProducts);
    on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    try {
      final products = await repository.getAllProducts();
      emit(ProductLoadedState(products));
    }
    catch(e) {
      emit(ProductErrorState(e.toString()));
    }

  }

  _onCreateProduct(CreateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    try {
      await repository.createProduct(event.product.toJson());
      add(LoadProducts());
    }
    catch(e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    try {
      String message = await repository.updateProduct(event.product.id!, event.product.toJson());

      emit(ProductSuccessState(message));

      add(LoadProducts());
    }
    catch(e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    try {
      String message = await repository.deleteProduct(event.productId);

      emit(ProductSuccessState(message));

      add(LoadProducts());
    }
    catch(e) {
      emit(ProductErrorState(e.toString()));
    }
  }

}