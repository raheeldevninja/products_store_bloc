import 'dart:developer';
import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/core/product/service/product_service.dart';

class ProductRepository {

  final ProductService productService;

  ProductRepository(this.productService);

  Future<List<Product>> getAllProducts() async {

    final response = await productService.getAllProducts();

    log('products response: ${response.body}');

    if (response.isSuccessful) {
      final List<dynamic> data = response.body;
      return data.map((json) => Product.fromJson(json)).toList();
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

  Future<Product> createProduct(Map<String, dynamic> product) async {

    final response = await productService.createProduct(product);

    log('create product response: ${response.body}');

    try {
      if(response.isSuccessful) {
        return Product.fromJson(response.body);
      }
      else {
        throw Exception(response.error);
      }
    }
    catch(e) {
      throw Exception(response.error ?? 'Failed to add product.');
    }

  }

  Future<String> updateProduct(int id, Map<String, dynamic> product) async {
    final response = await productService.updateProduct(id, product);
    log('update product response: ${response.body}');

    try {
      if(response.isSuccessful) {
        return 'Product updated.';
      }
      else {
        throw Exception(response.error);
      }

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

  Future<List<String>> getCategories() async {

    final response = await productService.getCategories();

    log('get categories response: ${response.body}');

    if(response.isSuccessful) {
      final List<dynamic> data = response.body;
      return data.map((e) => e.toString()).toList();
    }
    else {
      throw Exception(response.error);
    }
  }

  Future<List<Product>> getCategoryProducts(String category) async {

    final response = await productService.getCategoryProducts(category);

    log('get category products response: ${response.body}');

    if(response.isSuccessful) {
      final List<dynamic> data = response.body;
      return data.map((json) => Product.fromJson(json)).toList();
    }
    else {
      throw Exception(response.error);
    }
  }

}