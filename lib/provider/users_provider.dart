import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:promotoraapp/Model/users_model.dart';

class UsersProvider {
  final String _url = "http://66.228.51.95:1337/users";

  Future<UsersModel> getUsers() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        UsersModel users = UsersModel.fromMap(jsonResponse[0]);

        return users;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {}

    return null;
  }
}
