import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:mi_promotora/models/user_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

class UsersProvider {
  final String _url =
      GlobalConfiguration().getValue("api_url") + "/users?_sort=name";
  final _prefs = new UserPreferences();

  Future<List<UserModel>> getUsers() async {
    try {
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<UserModel> users = [];

        for (var item in jsonResponse) {
          UserModel user = UserModel.fromMap(item);
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

  Future<UserModel> getUser(int id) async {
    final String _endpoint = _url.toString() + '/' + id.toString();

    try {
      var response = await http.get(_endpoint);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        UserModel user = UserModel.fromMap(jsonResponse);

        return user;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }

  Future<bool> updateUser(UserModel user) async {
    final String _endpoint = _url.toString() + '/' + user.id.toString();

    try {
      String token = _prefs.token;

      print("Updating user $user");

      var response = await http.put(
        _endpoint,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: user.toString(),
      );

      if (response.statusCode == 200) {
        print("User updated successfully");
        print(response.body);

        return true;
      } else {
        print(
            'Update user request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return false;
  }

  Future<bool> updateUserPass(UserModel user, String password) async {
    final String _endpoint = _url.toString() + '/' + user.id.toString();

    try {
      String token = _prefs.token;

      print("Updating password for user user ${user.id}");
      String body = json.jsonEncode({"password": password});

      var response = await http.put(
        _endpoint,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("User password updated successfully");
        print(response.body);

        return true;
      } else {
        print(
            'Update user request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return false;
  }

  Future<bool> updateUserDevice() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    try {
      if (_prefs.userId != null) {
        await _firebaseMessaging.requestNotificationPermissions();
        String token = await _firebaseMessaging.getToken();

        UserModel loggedUser = await getUser(_prefs.userId);
        loggedUser.deviceToken = token;

        print(
            'User ${loggedUser.id} has device token ${loggedUser.deviceToken}');

        return updateUser(loggedUser);
      } else {
        return false;
      }
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }
}
