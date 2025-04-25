import 'dart:convert';
import 'dart:developer';

import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/feature/cart/model/cart_product.dart';
import 'package:products_store_bloc/feature/cart/model/single_cart_model.dart';
import 'package:products_store_bloc/feature/cart/model/update_cart_model.dart';
import 'package:products_store_bloc/feature/cart/service/cart_service.dart';



class CartRepository {
  final CartService service;

  CartRepository(this.service);

  Future<SingleCartResponse> getSingleCartProducts(int id) async {

    final response = await service.getSingleCartProducts(id);

    log('get single cart products response: ${response.body}');

    if(response.isSuccessful) {
      return SingleCartResponse.fromJson(response.body);
    }
    else {
      throw Exception(response.error);
    }
  }

  Future<List<CartProduct>> addProductInCart(int id, UpdateCartModel payload) async {

    final response = await service.addProductInCart(id, payload.toJson());

    log('add product in cart response: ${jsonEncode(response.body)}');

    if(response.isSuccessful) {
      final List<dynamic> productsJson = response.body['products'];

      List<CartProduct> cartProducts = productsJson.map((productJson) {
        return CartProduct(
          product: Product.fromJson(productJson),
          quantity: productJson['quantity'],
        );
      }).toList();

      return cartProducts;
    }
    else {
      throw Exception(response.error);
    }
  }

}