import 'package:chopper/chopper.dart';

part 'cart_service.chopper.dart';

@ChopperApi()
abstract class CartService extends ChopperService {

  @Get(path: '/carts/{id}')
  Future<Response> getSingleCartProducts(@Path() int id);

  static CartService create([ChopperClient? client]) => _$CartService(client);

}