import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:promotoraapp/preferences/users_preferences.dart';

class AtacRequestsProvider {
  final String _url = "http://66.228.51.95:1337/atac-solicitudes";
  final _prefs = new LoginPreferences();

  Future<Map<String, dynamic>> login(
      String userid, String service, String interests) async {
    final authData = json.encode(
      {'user:id': userid, 'service': service, 'interests': interests},
    );

    print(authData);

    final resp = await http.post(
      _url,
      headers: {'content-type': 'application/json'},
      body: authData,
    );

    print(userid);
    print(service);

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('interests')) {
      _prefs.token = decodedResp['interests'];

      return {'ok': true, 'interests': decodedResp['interests']};
    }
  }
}
