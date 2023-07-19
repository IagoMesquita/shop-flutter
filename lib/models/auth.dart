import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  Future<void> _authenticate (
      String email, String password, String urlFragment) async{
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyCdAiC5URnx8alehCOTvG4phywQrOkwOsM';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    final body = jsonDecode(response.body);

    if(body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    }

    print(body);

  }

  Future<void> singup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

    Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
