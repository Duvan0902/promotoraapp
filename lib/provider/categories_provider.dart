import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:promotoraapp/Model/categories_model.dart';
import 'package:global_configuration/global_configuration.dart';

class CategoriesProvider {
  final String _url = GlobalConfiguration().getValue("api_url") +
      "categorias-preguntas-frecuentes";

  Future<List<FaqCategoriesModel>> getCategories() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        List<FaqCategoriesModel> categories = List();

        for (var item in jsonResponse) {
          FaqCategoriesModel category = FaqCategoriesModel.fromMap(item);
          categories.add(category);
        }

        return categories;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return null;
  }
}
