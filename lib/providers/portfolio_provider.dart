import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import 'package:mi_promotora/models/portfolio_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:global_configuration/global_configuration.dart';

class PortfolioProvider {
  final String _url = GlobalConfiguration().getValue("api_url");
  final _prefs = new UserPreferences();

  Future<List<PortfolioModel>> getPortfolio() async {
    final userName = _prefs.userName;
    final String _endpoint =
        "$_url/cartera-data?contacted=false&agent.username=$userName";

    print("Request to $_endpoint");

    List<PortfolioModel> portfolio = [];

    try {
      String token = _prefs.token;
      print("Token: $token");
      final response = await http.get(
        _endpoint,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        for (var item in jsonResponse) {
          PortfolioModel portfolioItem = PortfolioModel.fromMap(item);
          portfolio.add(portfolioItem);
          print(portfolioItem);
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print(e);
    }

    return portfolio;
  }

  Future<List<PortfolioModel>> getContactedCustomers() async {
    final username = _prefs.userName;
    final String _endpoint =
        "$_url/cartera-data?contacted=true&agent.username=$username";

    try {
      String token = _prefs.token;
      final response = await http
          .get(_endpoint, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<PortfolioModel> educationList = [];

        for (var item in jsonResponse) {
          PortfolioModel portfolioItem = PortfolioModel.fromMap(item);
          educationList.add(portfolioItem);
          print(portfolioItem);
        }

        return educationList;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print(e);
    }

    return [];
  }

  Future<PortfolioModel> updateContact(PortfolioModel portfolio) async {
    final String _endpoint = "$_url/cartera-data/${portfolio.id}";

    try {
      String token = _prefs.token;
      final response = await http.put(
        _endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: portfolio.toJson(),
      );

      print(_endpoint);

      if (response.statusCode == 200) {
        portfolio = PortfolioModel.fromJson(response.body);

        return portfolio;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print(e);
    }

    return null;
  }
}
