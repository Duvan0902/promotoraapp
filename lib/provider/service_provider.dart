import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:promotoraapp/Model/services_model.dart';

class ServicesProvider {
  final String _url = "http://66.228.51.95:1337/atac-servicios";

  Future<List<ServicesModel>> getService() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ServicesModel> contacts = List();

        for (var item in jsonResponse) {
          ServicesModel contact = ServicesModel.fromMap(item);
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
