import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:promotoraapp/Model/education_model.dart';

class EducationProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/educacions";

  Future<List<EducationModel>> getEducation() async {
    try {
      final response = await http.get(_url);

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
