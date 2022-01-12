import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/models/education_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

class EducationProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/educacions";
  final _prefs = new UserPreferences();

  Future<List<EducationModel>> getAll() async {
    try {
      String token = _prefs.token;
      final response =
          await http.get(_url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<EducationModel> educationList = [];

        for (var item in jsonResponse) {
          EducationModel education = EducationModel.fromMap(item);
          educationList.add(education);
          print(education);
        }

        return educationList;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print(e);
    }

    return [];
  }

  Future<EducationModel> getById(int id) async {
    String endpoint = _url + '/$id';

    try {
      String token = _prefs.token;
      final response =
          await http.get(endpoint, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.jsonDecode(response.body);

        EducationModel education = EducationModel.fromMap(jsonResponse);
        print(education);

        return education;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
