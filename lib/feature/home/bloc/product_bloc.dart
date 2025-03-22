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
    on<GetCategories>(_onGetCategories);
  }

  _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(LoadingState());

    try {
      final products = await repository.getAllProducts();
      emit(ProductLoadedState(products));
    }
    catch(e) {
      emit(ErrorState(e.toString()));
    }

  }

  _onCreateProduct(CreateProduct event, Emitter<ProductState> emit) async {
    emit(LoadingState());

    try {
      await repository.createProduct(event.product.toJson());
      add(LoadProducts());
    }
    catch(e) {
      emit(ErrorState(e.toString()));
    }
  }

  _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(LoadingState());

    try {
      String message = await repository.updateProduct(event.product.id!, event.product.toJson());

      emit(SuccessState(message));

      add(LoadProducts());
    }
    catch(e) {
      emit(ErrorState(e.toString()));
    }
  }

  _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(LoadingState());

    try {
      String message = await repository.deleteProduct(event.productId);

      emit(SuccessState(message));

      add(LoadProducts());
    }
    catch(e) {
      emit(ErrorState(e.toString()));
    }
  }

  _onGetCategories(GetCategories event, Emitter<ProductState> emit) async {
    emit(LoadingState());

    try {
      final categories = await repository.getCategories();
      emit(CategoryLoadedState(categories));
    }
    catch(e) {
      emit(ErrorState(e.toString()));
    }

  }

}