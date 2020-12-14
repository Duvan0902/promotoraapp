import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:promotoraapp/Model/login_model.dart';
import 'package:promotoraapp/preferences/login_preferences.dart';

class UsersProvider {
  final _prefs = new LoginPreferences();

  Future<LoginModel> login(String email, String password) async {
    final String _url = "http://66.228.51.95:1337/auth/local";
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(_url, body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('Token')) {
      _prefs.token = decodedResp['Token'];
    } else {
      return null;
    }
  }
}
