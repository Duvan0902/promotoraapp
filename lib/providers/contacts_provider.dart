import 'package:http/http.dart' as http;
import 'package:mi_promotora/models/contact_model_interface.dart';
import 'package:mi_promotora/models/contacts_model.dart';
import 'dart:convert' as json;
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/models/user_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

class ContactsProvider {
  final String _url = GlobalConfiguration().getValue("api_url");
  final _prefs = new UserPreferences();

  Future<List<ContactModelInterface>> getContacts() async {
    String endpoint = _url + "/contactos";

    try {
      String token = _prefs.token;
      final response = await http.get(
        endpoint,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ContactModelInterface> contacts = [];

        for (var item in jsonResponse) {
          ContactsModel user = ContactsModel.fromMap(item);
          contacts.add(user);
        }

        List<ContactModelInterface> userContacts =
            await getUserContacts(employee: false);

        contacts.addAll(userContacts);
        contacts.sort((a, b) => a.name.compareTo(b.name));

        return contacts;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return [];
  }

  Future<List<ContactModelInterface>> getUserContacts(
      {bool employee = true}) async {
    final String endpoint = _url + '/users?is_employee_eq=$employee&_sort=name';

    try {
      var response = await http.get(endpoint);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ContactModelInterface> users = [];

        for (var item in jsonResponse) {
          UserModel user = UserModel.fromMap(item);
          users.add(user);
        }

        users.sort((a, b) => a.name.compareTo(b.name));

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
