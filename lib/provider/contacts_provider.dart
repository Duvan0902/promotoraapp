import 'package:http/http.dart' as http;
import 'package:promotoraapp/Model/contacts_model.dart';
import 'dart:convert' as json;

class ContactsProvider {
  final String _url = "http://66.228.51.95:1337/contactos";

  Future<List<ContactsModel>> getContacts() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ContactsModel> users = List();

        for (var item in jsonResponse) {
          ContactsModel user = ContactsModel.fromMap(item);
          users.add(user);
        }

        return users;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return [];
  }
}
