import 'dart:developer';
import 'package:products_store_bloc/feature/home/service/product_service.dart';

class ProductRepository {

  final ProductService productService;

  ProductRepository(this.productService);

  Future<List<dynamic>> getAllProducts() async {

    final response = await productService.getAllProducts();

    log('products response: ${response.body}');

    if(response.isSuccessful) {
      return response.body as List<dynamic>;
    }
    else {
      throw Exception(response.error);
    }

  }

}