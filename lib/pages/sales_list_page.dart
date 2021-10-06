import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_promotora/common/sale_item.dart';
import 'package:mi_promotora/models/sales_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/sales_provider.dart';

class SalesListPage extends StatefulWidget {
  final SalesCategoryModel category;
  final String date;

  SalesListPage({Key key, this.category, this.date}) : super(key: key);

  @override
  _SalesListPageState createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  @override
  Widget build(BuildContext context) {
    SalesProvider salesProvider = SalesProvider();
    UserPreferences _prefs = UserPreferences();
    int _username = _prefs.userId;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[900],
        title: new Text(
          "Mis ventas de ${widget.category.title}",
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
      body: FutureBuilder(
        future: salesProvider.getSalesByUser(
          widget.category.id,
          _username,
          widget.date,
        ),
        builder:
            (BuildContext context, AsyncSnapshot<List<SaleModel>> snapshot) {
          if (snapshot.hasData) {
            List<SaleModel> sales = snapshot.data;

            if (sales.isNotEmpty) {
              return Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: sales.length,
                  itemBuilder: (context, index) {
                    SaleModel sale = sales[index];

                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    final String created = formatter.format(sale.date);

                    return FlexibleExpansionCard(
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(created),
                          Text("\$${sale.value}"),
                        ],
                      ),
                      detail: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cliente"),
                              Text(sale.client),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Identificación"),
                              Text(sale.idClient),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              Size size = MediaQuery.of(context).size;
              return Center(
                child: Container(
                  width: size.width * 0.8,
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "No tienes ventas asociadas de esta categoría desde la fecha seleccionada (${widget.date})",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black)),
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
