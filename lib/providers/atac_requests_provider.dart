import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:promotoraapp/preferences/users_preferences.dart';

class AtacRequestsProvider {
  final String _url =
      GlobalConfiguration().getValue("api_url") + "/atac-solicitudes";
  final _prefs = new UserPreferences();

  Future<bool> sendInterests(
      String userid, String service, String interests) async {
    final bodyData = json.encode(
      {'user_id': userid, 'service': service, 'interests': interests},
    );

    print(bodyData);
    String token = _prefs.token;

    final resp = await http.post(
      _url,
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: bodyData,
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
