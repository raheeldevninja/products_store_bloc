import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_event.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_state.dart';
import 'package:products_store_bloc/feature/cart/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository repository;

  CartBloc(this.repository) : super(CartInitialState()) {
    on<GetSingleCartProducts>(_onGetSingleCartProducts);
    on<AddProductInCart>(_onAddProductInCart);
  }

  _onGetSingleCartProducts( GetSingleCartProducts event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      final cartProducts = await repository.getSingleCartProducts(event.cartId);
      emit((CartLoadedState(cartProducts)));
    }
    catch(e) {
      emit(CartErrorState(e.toString()));
    }

  }

  _onAddProductInCart(AddProductInCart event, Emitter<CartState> emit) {

  }

}