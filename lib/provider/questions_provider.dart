import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:promotoraapp/Model/questions_model.dart';

class QuestionsProvider {
  final String _url =
      "http://66.228.51.95:1337/categorias-preguntas-frecuentes";

  Future<QuestionsModel> getQuestions() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        QuestionsModel event = QuestionsModel.fromMap(jsonResponse[0]);

        return event;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return null;
  }
}
