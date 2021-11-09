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
        "$_url/carteras?contacted=false&agent.username=$userName";

    print("Request to $_endpoint");

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

  Future<List<PortfolioModel>> getContactedCustomers() async {
    final username = _prefs.userName;
    final String _endpoint =
        "$_url/carteras?contacted=true&agent.username=$username";

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
    final String _endpoint = "$_url/carteras/${portfolio.id}";

    try {
      print("Update contact with this info: ${portfolio.toJson()}");

      String token = _prefs.token;
      final response = await http.put(
        _endpoint,
        headers: {'Authorization': 'Bearer $token'},
        body: portfolio.toJson(),
      );

      print("Update contact");
      print(response.body);
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
