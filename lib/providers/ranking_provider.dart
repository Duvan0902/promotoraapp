import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:global_configuration/global_configuration.dart';
import 'package:promotoraapp/models/ranking_model.dart';

class RankingProvider {
  final String _url = GlobalConfiguration().getValue("api_url") +
      "/reporte-integrado-data/ranking";

  Future<List<RankingDataModel>> getRanking() async {
    try {
      final response = await http.get(
        _url,
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<RankingDataModel> contacts = List();

        for (var item in jsonResponse) {
          RankingDataModel contact = RankingDataModel.fromMap(item);
          contacts.add(contact);
        }

        return contacts;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return [];
  }
}
