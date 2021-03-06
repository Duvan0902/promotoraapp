import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:global_configuration/global_configuration.dart';

class LoginProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/auth/local";
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final authData = json.encode(
      {'identifier': identifier, 'password': password},
    );

    final resp = await http.post(
      _url,
      headers: {'content-type': 'application/json'},
      body: authData,
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('jwt')) {
      _prefs.token = decodedResp['jwt'];
      _prefs.userName = decodedResp['user']['username'];
      _prefs.userId = decodedResp['user']['id'];
      _prefs.userEmail = decodedResp['user']['email'];

      print(decodedResp['user']['id']);
      print(decodedResp['user']['username']);
      print(decodedResp['user']['email']);

      return {'ok': true, 'jwt': decodedResp['jwt']};
    } else {
      print(decodedResp['message'][0]['messages'][0]['id']);
      switch (decodedResp['message'][0]['messages'][0]['id']) {
        case "Auth.form.error.invalid":
          print('message');
          return {
            'ok': false,
            'message':
                'Correo o contraseña inválidos. Por favor vuelve a intentarlo.',
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
