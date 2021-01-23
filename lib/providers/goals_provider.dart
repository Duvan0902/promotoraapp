import 'package:http/http.dart' as http;
import 'package:MiPromotora/models/goals_model.dart';
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:MiPromotora/preferences/users_preferences.dart';

class GoalsProvider {
  final _prefs = new UserPreferences();

  final String _url = GlobalConfiguration().getValue("api_url") +
      "/reporte-integrado-data?user_code=1585&branch_gct=Total&_sort=integrated_report:DESC&_limit=1";
  Future<GoalsModel> getGoal() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        GoalsModel goal = GoalsModel.fromMap(jsonResponse[0]);

        return goal;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }
}
