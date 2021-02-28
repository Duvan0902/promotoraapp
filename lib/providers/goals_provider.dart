import 'package:intl/intl.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mi_promotora/models/goals_model.dart';
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';

class GoalsProvider {
  final _prefs = new UserPreferences();

  Future<GoalsModel> getGoal() async {
    String userName = _prefs.userName;
    String token = _prefs.token;
    final String _url = GlobalConfiguration().getValue("api_url") +
        "/reporte-integrado-data?user_code=$userName&branch_gct=Total&_sort=integrated_report:DESC&_limit=1";
    print(_url);
    try {
      var response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );

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

  Future<List<GoalsModel>> getHistoric(DateTime date) async {
    String userName = _prefs.userName;
    String token = _prefs.token;
    String dateFilter = DateFormat('yyyy-MM-dd').format(date);

    final String _url = GlobalConfiguration().getValue("api_url") +
        "/reporte-integrado-data?user_code=$userName&branch_gct=Total&report_date_gte=$dateFilter&_limit=10";

    try {
      var response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );

      print(_url);
      if (response.statusCode == 200) {
        print('Get Historic ${response.body}');
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<GoalsModel> goals = [];

        for (var item in jsonResponse) {
          GoalsModel goal = GoalsModel.fromMap(item);
          goals.add(goal);
        }

        return goals;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }
}
