import 'package:chopper/chopper.dart';

part 'auth_service.chopper.dart';

@ChopperApi()
abstract class AuthService extends ChopperService {

  @Post(path: '/auth/login')
  Future<Response> login(@Body() Map<String, dynamic> body);

  @Post(path: '/users')
  Future<Response> register(@Body() Map<String, dynamic> body);

  static AuthService create([ChopperClient? client]) => _$AuthService(client);
}