import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/models/ranking_model.dart';

class RankingProvider {
  final String _url = GlobalConfiguration().getValue("api_url") +
      "/reporte-integrado-data/ranking";

  Future<List<RankingModel>> getRanking() async {
    try {
      final response = await http.get(
        _url,
      );

      if (response.statusCode == 200) {
        // print(response.body);
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        List<RankingModel> ranking = List();

        jsonResponse.forEach((key, value) {
          ranking.add(RankingModel.fromMap(jsonResponse, key));
        });

        return ranking;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return [];
  }
}
