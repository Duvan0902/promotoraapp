import 'package:http/http.dart' as http;
import 'package:promotoraapp/Model/atac_model.dart';
import 'dart:convert' as json;

class ServicesProvider {
  final String _url = "http://66.228.51.95:1337/atacs";

  Future<List<AtacModel>> getService() async {
    try {
      var response = await http.get(_url);

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
