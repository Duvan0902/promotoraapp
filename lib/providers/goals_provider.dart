import 'package:http/http.dart' as http;
import 'package:MiPromotora/models/goals_model.dart';
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:MiPromotora/preferences/users_preferences.dart';

class GoalsProvider {
  final String _url = GlobalConfiguration().getValue("api_url") +
      "/reporte-integrado-data?user_code=1585&branch_gct=Total&_sort=integrated_report:DESC&_limit=1";
  final _prefs = new UserPreferences();
  Future<List<GoalsModel>> getGoals() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<GoalsModel> goals = List();

        for (var item in jsonResponse) {
          GoalsModel goal = GoalsModel.fromMap(item);
          goals.add(goal);
        }

        return goals;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print('dd');
    }

    return [];
  }

  Future<int> saleCount() async {
    int sales;
    try {
      int id = _prefs.userId;
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-01');

      String formattedDate = formatter.format(now);
      final response = await http.get(
        "http://66.228.51.95:1337/ventas/count?user=$id&created_at_gte=$formattedDate",
      );

      if (response.statusCode == 200) {
        sales = int.parse(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }
    return sales;
  }
}
