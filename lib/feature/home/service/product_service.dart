import 'package:chopper/chopper.dart';

part 'product_service.chopper.dart';

@ChopperApi()
abstract class ProductService extends ChopperService {

  @Get(path: 'products')
  Future<Response> getAllProducts();

  @Post(path: 'products')
  Future<Response> createProduct(@Body() Map<String, dynamic> product);

  static ProductService create([ChopperClient? client]) => _$ProductService(client);

}