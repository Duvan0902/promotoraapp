import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:promotoraapp/preferences/login_preferences.dart';

class UsuarioProvider {
  final String _url = 'http://66.228.51.95:1337/auth/local';
  final _prefs = new LoginPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(_url, body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
