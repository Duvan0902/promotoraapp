import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:mi_promotora/common/total_box.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/sales_model.dart';
import 'package:mi_promotora/pages/sales_list_page.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/sales_provider.dart';
import 'package:mi_promotora/utils/random_color.dart';

class SalesCategoriesPage extends StatelessWidget {
  final String _url = GlobalConfiguration().getValue("api_url");
  final salesProvider = SalesProvider();
  final _prefs = UserPreferences();

  SalesCategoriesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[900],
        title: new Text(
          "Mis ventas",
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          padding: EdgeInsets.only(left: 75),
          child: Icon(Icons.ac_unit),
        ),
      ),
      body: Container(
        color: Colors.grey[900],
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Aquí encontrarás el resumen de tus ventas del mes.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontSize: 17),
              ),
            ),
            _totalSales(context),
            _categories(context),
          ],
        ),
      ),
    );
  }

  Widget _categories(context) {
    return FutureBuilder(
      future: salesProvider.getSalesCategories(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _categoriesList(context, snapshot.data);
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _categoriesList(
      BuildContext context, List<SalesCategoryModel> salesCategories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: salesCategories.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return _category(context, salesCategories[index]);
      },
    );
  }

  Widget _category(BuildContext context, SalesCategoryModel category) {
    return InkWell(
      child: ClipRect(
        child: Container(
          height: 150.0,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: generateRandomColor(),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
                child: category.icon != null
                    ? Image.network(
                        _url + category.icon.url,
                        color: Colors.black,
                        width: 30,
                        height: 30,
                        scale: 1,
                      )
                    : SizedBox.shrink(),
              ),
              Text(
                category.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0)
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalesListPage(category: category),
          ),
        );
      },
    );
  }

  Widget _totalSales(context) {
    return FutureBuilder(
      future: salesProvider.getSalesByUser(null, _prefs.userId),
      builder: (BuildContext context, AsyncSnapshot<List<SaleModel>> snapshot) {
        if (snapshot.hasData) {
          List<SaleModel> sales = snapshot.data;

          double total = sales
              .map((e) => double.tryParse(e.value))
              .reduce((a, b) => a + b);

          final NumberFormat currencyFormat = NumberFormat.currency(
              locale: 'es_CO',
              symbol: '\$',
              decimalDigits: 0,
              customPattern: '\u00A4###,###');
          String formattedTotal = currencyFormat.format(total);

          print(formattedTotal);

          return TotalBox(
            lefttext: 'Total',
            rigthtext: formattedTotal,
            background: MiPromotora().accent,
            fontcolor: Colors.white,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
