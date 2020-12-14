import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:promotoraapp/Model/login_model.dart';
import 'package:promotoraapp/preferences/login_preferences.dart';

class LoginProvider {
  final _prefs = LoginPreferences();

  Future<LoginModel> login(String email, String password) async {
    final String _url = "http://66.228.51.95:1337/auth/local";

    try {
      String basicAuth = 'Basic';
      var response = await http.post(
        _url,
        headers: <String, String>{
          'authorization': basicAuth,
          'content-type': 'application/json'
        },
      );

      switch (response.statusCode) {
        case 200:
          String token = json.decode(response.body)["token"];

          LoginModel user = await getLogin(token);
          return user;
          break;
        default:
      }
    } catch (Exception) {
      print(Exception);
    }
    return null;
  }

  Future<LoginModel> getLogin(String token) async {
    final String _url = "http://66.228.51.95:1337/auth/local" + token;

    try {
      String basicAuth = 'Basic ';

      var response = await http.get(
        _url,
        headers: <String, String>{
          'authorization': basicAuth,
          'content-type': 'application/json'
        },
      );

      LoginModel user = LoginModel.fromJson(response.body);

      if (user.mail != null) {
        print("Token saved");
        _prefs.token = token;
      }

      return user;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }
}
