import 'package:http/http.dart' as http;
import 'package:promotoraapp/models/atac_model.dart';
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:promotoraapp/preferences/users_preferences.dart';

class ServicesProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/atacs";

  final _prefs = new UserPreferences();

  Future<List<AtacModel>> getService() async {
    try {
      String token = _prefs.token;
      final response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print(_prefs.token);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<AtacModel> contacts = List();

        for (var item in jsonResponse) {
          AtacModel contact = AtacModel.fromMap(item);
          contacts.add(contact);
        }

        return contacts;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return [];
  }
}
