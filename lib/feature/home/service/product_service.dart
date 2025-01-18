import 'package:chopper/chopper.dart';

part 'product_service.chopper.dart';

@ChopperApi()
abstract class ProductService extends ChopperService {

  @Get(path: 'products')
  Future<Response> getAllProducts();

  static ProductService create([ChopperClient? client]) => _$ProductService(client);

}