import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:?key=AIzaSyCdAiC5URnx8alehCOTvG4phywQrOkwOsM';

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

    print(jsonDecode(response.body));

  }

  Future<void> singup(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

    Future<void> login(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }
}
