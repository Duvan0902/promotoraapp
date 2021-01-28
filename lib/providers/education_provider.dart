import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/models/education_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

class EducationProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/educacions";
  final _prefs = new UserPreferences();

  Future<List<EducationModel>> getEducation() async {
    try {
      String token = _prefs.token;
      final response =
          await http.get(_url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<EducationModel> educations = List();

        for (var item in jsonResponse) {
          EducationModel education = EducationModel.fromMap(item);
          educations.add(education);
        }

        return educations;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return [];
  }
}
