import 'package:chopper/chopper.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: '/auth')
abstract class AuthService extends ChopperService {

  @Post(path: '/login')
  Future<Response> login(@Body() Map<String, dynamic> body);

  static AuthService create([ChopperClient? client]) => _$AuthService(client);
}