import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:promotoraapp/Model/users_model.dart';

class UsersProvider {
  final String _url = "http://66.228.51.95:1337/users";

  Future<List<UsersModel>> getUser(int id) async {
    String _endpoint = id == null ? _url + '/1' : _url + '/$id';

    try {
      var response = await http.get(_endpoint);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<UsersModel> users = List();

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
