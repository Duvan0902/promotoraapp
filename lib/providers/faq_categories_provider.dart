import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:mi_promotora/models/categories_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

class FaqCategoriesProvider {
  final String _url = GlobalConfiguration().getValue("api_url") +
      "/categorias-preguntas-frecuentes";
  final _prefs = new UserPreferences();

  Future<List<FaqCategoriesModel>> getCategories() async {
    try {
      String token = _prefs.token;
      final response = await http.get(
        _url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(_prefs.token);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        List<FaqCategoriesModel> categories = [];

        for (var item in jsonResponse) {
          FaqCategoriesModel category = FaqCategoriesModel.fromMap(item);
          categories.add(category);
        }

        return categories;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }

  Future<FaqCategoriesModel> getCategory(String id) async {
    String endpoint = _url + '/$id';

    try {
      String token = _prefs.token;
      final response = await http.get(
        endpoint,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        dynamic jsonResponse = json.jsonDecode(response.body);

        FaqCategoriesModel category = FaqCategoriesModel.fromMap(jsonResponse);

        return category;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }
}
