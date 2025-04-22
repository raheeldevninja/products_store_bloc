import 'package:chopper/chopper.dart';

part 'product_service.chopper.dart';

@ChopperApi()
abstract class ProductService extends ChopperService {

  @Get(path: '/products')
  Future<Response> getAllProducts();

  @Get(path: '/products/{id}')
  Future<Response> getSingleProduct(@Path() int id);

  @Post(path: '/products')
  Future<Response> createProduct(@Body() Map<String, dynamic> product);

  @Put(path: '/products/{id}')
  Future<Response> updateProduct(@Path() int id, @Body() Map<String, dynamic> product);

  @Delete(path: '/products/{id}')
  Future<Response> deleteProduct(@Path() int id);

  @Get(path: 'products/categories')
  Future<Response> getCategories();

  @Get(path: 'products/category/{category}')
  Future<Response> getCategoryProducts(@Path() String category);

  static ProductService create([ChopperClient? client]) => _$ProductService(client);

}