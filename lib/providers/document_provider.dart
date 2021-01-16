import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:promotoraapp/models/documents_model.dart';
import 'package:promotoraapp/preferences/users_preferences.dart';

class DocumentsProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/documentos";
  final _prefs = new UserPreferences();

  Future<List<DocumentsModel>> getDocuments() async {
    String token = _prefs.token;
    try {
      final response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print(_prefs.token);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<DocumentsModel> documents = List();

        for (var item in jsonResponse) {
          DocumentsModel document = DocumentsModel.fromMap(item);
          documents.add(document);
        }

        return documents;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return [];
  }
}
