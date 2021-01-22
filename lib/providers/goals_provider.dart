import 'package:http/http.dart' as http;
import 'package:MiPromotora/models/goals_model.dart';
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';

class GoalsProvider {
  final String _url = GlobalConfiguration().getValue("api_url") +
      "/reporte-integrado-data?user_code=1585&branch_gct=Total&_sort=integrated_report:DESC&_limit=1";

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
}
