import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_event.dart';
import 'package:products_store_bloc/feature/cart/bloc/cart_state.dart';
import 'package:products_store_bloc/feature/cart/model/cart_product.dart';
import 'package:products_store_bloc/feature/cart/model/update_cart_model.dart';
import 'package:products_store_bloc/feature/cart/repository/cart_repository.dart';
import 'package:products_store_bloc/feature/home/repository/product_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository repository;
  final ProductRepository productRepository;

  CartBloc(this.repository, this.productRepository) : super(CartInitialState()) {
    on<GetSingleCartProducts>(_onGetSingleCartProducts);
    on<AddProductInCart>(_onAddProductInCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
  }

  _onGetSingleCartProducts( GetSingleCartProducts event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      final cartResponse = await repository.getSingleCartProducts(event.cartId);

      final List<CartProduct> cartItems = [];

      for (var cartProduct in cartResponse.cartProducts ?? []) {
        final product = await productRepository.getSingleProduct(cartProduct.productId ?? 0);
        cartItems.add(
            CartProduct(
              product: product,
              quantity: cartProduct.quantity ?? 0,
            )
        );
      }

      emit((CartLoadedState(cartItems)));
    }
    catch(e) {
      emit(CartErrorState(e.toString()));
    }

  }

  _onAddProductInCart(AddProductInCart event, Emitter<CartState> emit) async {

    emit(CartLoadingState());

    try {
      final updateCartResponse = await repository.addProductInCart(event.id, event.payload);

      emit((CartLoadedState(updateCartResponse)));
    }
    catch(e) {
      emit(CartErrorState(e.toString()));
    }

  }

  void _onRemoveProductFromCart(RemoveProductFromCart event, Emitter<CartState> emit) async {
    final currentState = state;

    if (currentState is CartLoadedState) {
      emit(CartLoadingState());

      try {
        // 1. Remove the product locally
        final updatedCartItems = currentState.cartItems.where(
              (cartProduct) => cartProduct.product.id != event.productId,
        ).toList();

        // 2. Create UpdateCartModel
        UpdateCartModel cartModel = UpdateCartModel(
          id: event.cartId,
          userId: 0, // your user id (0 here)
          products: updatedCartItems,
        );

        // 3. Call the update API
        final updateCartResponse = await repository.addProductInCart(event.cartId, cartModel);

        // 4. Emit the updated cart state
        emit(CartLoadedState(updateCartResponse));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    }
  }


}