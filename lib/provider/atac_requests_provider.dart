import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:promotoraapp/preferences/users_preferences.dart';

class AtacRequestsProvider {
  final String _url = "http://66.228.51.95:1337/atac-solicitudes";
  Future<bool> sendInterests(
      String userid, String service, String interests) async {
    final bodyData = json.encode(
      {'user_id': userid, 'service': service, 'interests': interests},
    );

    print(bodyData);

    final resp = await http.post(
      _url,
      headers: {'content-type': 'application/json'},
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
