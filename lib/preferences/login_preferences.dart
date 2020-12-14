import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences {
  static final LoginPreferences _instance = new LoginPreferences._internal();

  factory LoginPreferences() {
    return _instance;
  }

  LoginPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  set token(String token) => _prefs.setString('token', token);

  String get token => _prefs.getString('token');
}
