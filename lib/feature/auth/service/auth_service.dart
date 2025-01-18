import 'package:chopper/chopper.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: '/auth')
abstract class AuthService extends ChopperService {

  @Post(path: '/login')
  Future<Response> login(@Body() Map<String, dynamic> body);

  static AuthService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://fakestoreapi.com'),
      services: [
        _$AuthService(),
      ],
      converter: const JsonConverter(),
    );

    return _$AuthService(client);
  }
}