import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password, Uri url) async {
    // print(url);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.https(
      'identitytoolkit.googleapis.com',
      '/v1/accounts:signUp',
      {'key': 'AIzaSyBhDb4QrmZqsAy4WvvWs1tQtfLsDsGg5yI'},
    );
    return _authenticate(email, password, url);
  }

  Future<void> login(String email, String password) async {
    final url = Uri.https(
      'identitytoolkit.googleapis.com',
      '/v1/accounts:signInWithPassword',
      {'key': 'AIzaSyBhDb4QrmZqsAy4WvvWs1tQtfLsDsGg5yI'},
    );

    return _authenticate(email, password, url);
  }
}
