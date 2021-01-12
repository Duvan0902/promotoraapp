import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

class SalesProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/ventas";

  Future<bool> sendSale(String type, String date, String value, String client,
      String idclient, String user) async {
    final bodyData = json.encode(
      {
        'type': type,
        'date': date,
        'value': value,
        'client': client,
        'id_client': idclient,
        'user': user
      },
    );
    print(bodyData);

    final resp = await http.post(
      _url,
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
