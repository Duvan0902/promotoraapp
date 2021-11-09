import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/models/sales_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:intl/intl.dart';

class SalesProvider {
  final String _url = GlobalConfiguration().getValue("api_url");
  final _prefs = new UserPreferences();

  Future<SaleModel> sendSale(String type, String date, String value,
      String client, String idclient, String user) async {
    SaleModel sale;

    final bodyData = json.encode(
      {
        'type': type,
        'category': type,
        'date': date,
        'value': value,
        'client': client,
        'id_client': idclient,
        'user': user
      },
    );
    print(bodyData);

    String token = _prefs.token;

    final resp = await http.post(
      _url + "/ventas",
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json',
      },
      body: bodyData,
    );

    if (resp.statusCode == 200) {
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      sale = SaleModel.fromMap(decodedResp);
      print(decodedResp);
    } else {
      print('Request failed with status: ${resp.statusCode}.');
      sale = null;
    }
    return sale;
  }

  Future<int> getSalesCount() async {
    int sales = 0;
    String priv = _prefs.token;
    try {
      int id = _prefs.userId;
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-01');
      String formattedDate = formatter.format(now);

      String requestUrl =
          _url + "/ventas/count?user=$id&created_at_gte=$formattedDate";
      print(requestUrl);

      final response = await http.get(
        requestUrl,
        headers: {'Authorization': 'Bearer $priv'},
      );

      if (response.statusCode == 200) {
        sales = int.parse(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }
    return sales;
  }

  Future<List<SalesCategoryModel>> getSalesCategories() async {
    List<SalesCategoryModel> salesCategories = [];

    try {
      String token = _prefs.token;
      String salesCategoriesUrl = _url + "/ventas-categorias";

      print(salesCategoriesUrl);

      final response = await http.get(
        salesCategoriesUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Categories: ${response.body}");
        List<dynamic> jsonResponse = jsonDecode(response.body);

        for (var item in jsonResponse) {
          SalesCategoryModel saleCategory = SalesCategoryModel.fromMap(item);
          salesCategories.add(saleCategory);
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }

    return salesCategories;
  }

  Future<List<SaleModel>> getSalesByUser(
      int categoryId, int userId, String startDate, String endDate) async {
    List<SaleModel> sales = [];

    try {
      String token = _prefs.token;
      String salesCategoriesUrl = categoryId == null
          ? '$_url/ventas?user.id=$userId'
          : '$_url/ventas?user.id=$userId&category.id=$categoryId';

      if (startDate != null) {
        salesCategoriesUrl += "&created_at_gte=$startDate";
      }

      if (endDate != null) {
        salesCategoriesUrl += "&created_at_lte=$endDate";
      }

      print(salesCategoriesUrl);

      final response = await http.get(
        salesCategoriesUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonResponse = jsonDecode(response.body);

        for (var item in jsonResponse) {
          SaleModel sale = SaleModel.fromMap(item);
          sales.add(sale);
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (Exception) {
      print(Exception);
    }

    return sales;
  }

  Future<bool> deleteSale(SaleModel sale) async {
    try {
      String token = _prefs.token;
      String deleteSaleUrl = '$_url/ventas/${sale.id}';

      print(deleteSaleUrl);

      final response = await http.delete(
        deleteSaleUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}
