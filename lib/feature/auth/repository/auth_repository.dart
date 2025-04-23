import 'dart:developer';

import 'package:products_store_bloc/feature/auth/service/auth_service.dart';

class AuthRepository {

  final AuthService service;

  AuthRepository(this.service);

  Future<Map<String, dynamic>> login(String username, String password) async {

    final response = await service.login({
      "username": username,
      "password": password
    });

    log('login response: ${response.body}');

    if(response.isSuccessful) {
      return response.body;
    }
    else {
      throw Exception(response.error);
    }

  }


  Future<Map<String, dynamic>> register(String email, String username, String password) async {

    final response = await service.register({
      "email": email,
      "username": username,
      "password": password
    });

    log('register response: ${response.body}');

    if(response.isSuccessful) {
      return response.body;
    }
    else {
      throw Exception(response.error);
    }

  }


}