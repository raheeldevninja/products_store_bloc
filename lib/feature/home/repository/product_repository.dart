import 'dart:developer';
import 'package:products_store_bloc/feature/home/model/product.dart';
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

  Future<Product> getSingleProduct(int id) async {

    final response = await productService.getSingleProduct(id);

    log('get single product response: ${response.body}');

    if(response.isSuccessful) {
      return Product.fromJson(response.body);
    }
    else {
      throw Exception(response.error);
    }
  }

  Future<void> createProduct(Map<String, dynamic> product) async {

    final response = await productService.createProduct(product);

    log('create product response: ${response.body}');

    if(response.isSuccessful) {
      return response.body;
    }
    else {
      throw Exception(response.error);
    }

  }

  Future<String> updateProduct(int id, Map<String, dynamic> product) async {
    final response = await productService.updateProduct(id, product);
    log('update product response: ${response.body}');

    try {
      return 'Product updated.';
    }
    catch(e) {
      throw Exception(response.error ?? 'Failed to update product.');
    }
  }

  Future<String> deleteProduct(int id) async {
    final response = await productService.deleteProduct(id);
    log('delete product response: ${response.body}');

    if(response.isSuccessful) {
      return 'Product deleted successfully';
    }
    else {
      throw Exception(response.error ?? 'Failed to delete product.');
    }
  }

  Future<List<dynamic>> getCategories() async {

    final response = await productService.getCategories();

    log('get categories response: ${response.body}');

    if(response.isSuccessful) {
      return response.body as List<dynamic>;
    }
    else {
      throw Exception(response.error);
    }
  }

  Future<List<dynamic>> getCategoryProducts(String category) async {

    final response = await productService.getCategoryProducts(category);

    log('get category products response: ${response.body}');

    if(response.isSuccessful) {
      return response.body as List<dynamic>;
    }
    else {
      throw Exception(response.error);
    }
  }

}