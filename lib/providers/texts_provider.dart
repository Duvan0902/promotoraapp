import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

class TextsProvider {
  final String _url = GlobalConfiguration().getValue("texts");

  Future<String> getPrivacyText() async {
    try {
      String endpoint = _url + "/privacy-policy.md";

      print("Request to $endpoint");
      final response = await http.get(endpoint);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return "";
  }

  Future<String> getTermsText() async {
    try {
      String endpoint = _url + "/terms-and-conditions.md";

      print("Request to $endpoint");
      final response = await http.get(endpoint);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return "";
  }
}
