import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:promotoraapp/preferences/users_preferences.dart';

class LoginProvider {
  final String _url = "http://66.228.51.95:1337/auth/local";
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final authData = json.encode(
      {'identifier': identifier, 'password': password},
    );

    print(authData);

    final resp = await http.post(
      _url,
      headers: {'content-type': 'application/json'},
      body: authData,
    );

    print(identifier);
    print(password);

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('jwt')) {
      _prefs.token = decodedResp['jwt'];
      _prefs.userId = decodedResp['user']['id'];
      _prefs.userEmail = decodedResp['user']['email'];

      print(decodedResp['user']['id']);

      return {'ok': true, 'jwt': decodedResp['jwt']};
    } else {
      print(decodedResp['message'][0]['messages'][0]['id']);
      switch (decodedResp['message'][0]['messages'][0]['id']) {
        case "Auth.form.error.invalid":
          print('message');
          return {
            'ok': false,
            'message':
                'Correo o contraseña invalidos. Por favor vuelva intentarlo.',
          };
          break;
        default:
          return {
            'ok': false,
            'message': decodedResp['message'][0]['messages'][0]['id'],
          };
          break;
      }
    }
  }
}
