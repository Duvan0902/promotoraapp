import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/models/ranking_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

class RankingProvider {
  final String _url = GlobalConfiguration().getValue("api_url") +
      "/reporte-integrado-data/ranking";
  final _prefs = new UserPreferences();

  Future<List<RankingModel>> getRanking() async {
    String token = _prefs.token;
    try {
      final response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // print(response.body);
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        List<RankingModel> ranking = [];

        jsonResponse.forEach((key, value) {
          ranking.add(RankingModel.fromMap(jsonResponse, key));
        });

        return ranking;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print(e);
    }
    return [];
  }
}
