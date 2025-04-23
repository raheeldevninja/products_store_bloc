import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_event.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_state.dart';
import 'package:products_store_bloc/feature/cart/model/cart_product.dart';
import 'package:products_store_bloc/feature/cart/repository/cart_repository.dart';
import 'package:products_store_bloc/feature/home/repository/product_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository repository;
  final ProductRepository productRepository;

  CartBloc(this.repository, this.productRepository) : super(CartInitialState()) {
    on<GetSingleCartProducts>(_onGetSingleCartProducts);
    on<AddProductInCart>(_onAddProductInCart);

    add(GetSingleCartProducts(1));
  }

  _onGetSingleCartProducts( GetSingleCartProducts event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      final cartResponse = await repository.getSingleCartProducts(event.cartId);

      final List<CartProduct> cartItems = [];

      for (var cartProduct in cartResponse.cartProducts ?? []) {
        final product = await productRepository.getSingleProduct(cartProduct.productId ?? 0);
        cartItems.add(CartProduct(product: product, quantity: cartProduct.quantity ?? 0));
      }

      emit((CartLoadedState(cartItems)));
    }
    catch(e) {
      emit(CartErrorState(e.toString()));
    }

  }

  _onAddProductInCart(AddProductInCart event, Emitter<CartState> emit) {

  }

}