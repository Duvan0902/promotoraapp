import 'package:http/http.dart' as http;
import 'package:mi_promotora/models/contacts_model.dart';
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

class ContactsProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/contactos";
  final _prefs = new UserPreferences();

  Future<List<ContactsModel>> getContacts() async {
    try {
      String token = _prefs.token;
      final response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ContactsModel> users = [];

        for (var item in jsonResponse) {
          ContactsModel user = ContactsModel.fromMap(item);
          users.add(user);
        }

        return users;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return [];
  }
}
