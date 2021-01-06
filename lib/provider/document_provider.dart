import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:promotoraapp/Model/documents_model.dart';

class DocumentsProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/documentos";

  Future<List<DocumentsModel>> getDocuments() async {
    try {
      var response = await http.get(_url);

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
