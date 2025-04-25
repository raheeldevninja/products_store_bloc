import 'package:chopper/chopper.dart';
import 'package:products_store_bloc/core/product/service/product_service.dart';
import 'package:products_store_bloc/feature/auth/service/auth_service.dart';
import 'package:products_store_bloc/feature/cart/service/cart_service.dart';


ChopperClient createChopperClient() {
  return ChopperClient(
    baseUrl: Uri.parse('https://fakestoreapi.com'),
    services: [
      AuthService.create(),
      ProductService.create(),
      CartService.create(),
    ],
    converter: const JsonConverter(),
  );
}