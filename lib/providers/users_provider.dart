import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:mi_promotora/models/users_model.dart';
import 'package:global_configuration/global_configuration.dart';

class UsersProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/users";

  Future<List<UsersModel>> getUsers() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<UsersModel> users = [];

        for (var item in jsonResponse) {
          UsersModel user = UsersModel.fromMap(item);
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
