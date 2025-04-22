import 'dart:developer';

import 'package:products_store_bloc/feature/cart/model/single_cart_model.dart';
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


}