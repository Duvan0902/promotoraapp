import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  set token(String token) => _prefs.setString('token', token);

  String get token => _prefs.getString('token');

  set userId(int userId) => _prefs.setInt('id', userId);

  int get userId => _prefs.getInt('id');

  set userEmail(String email) => _prefs.setString('user', email);

  String get userEmail => _prefs.getString('user');
}
