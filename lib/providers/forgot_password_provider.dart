import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

class ForgotPasswordProvider {
  final String _url = GlobalConfiguration().getValue("api_url");

  Future<bool> sendPassword(String email) async {
    final bodyData = json.encode(
      {"email": email},
    );
    print(bodyData);

    final resp = await http.post(
      _url + "/auth/forgot-password",
      headers: {
        'content-type': 'application/json',
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
