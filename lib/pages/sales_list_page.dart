import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mi_promotora/common/formats.dart';
import 'package:mi_promotora/models/sales_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/sales_provider.dart';

import '../main.dart';

class SalesListPage extends StatefulWidget {
  final SalesCategoryModel category;
  final DateTime startDate;
  final DateTime endDate;

  SalesListPage({Key key, this.category, this.startDate, this.endDate})
      : super(key: key);

  @override
  _SalesListPageState createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  SalesProvider _salesProvider = SalesProvider();
  @override
  Widget build(BuildContext context) {
    UserPreferences _prefs = UserPreferences();
    List<SaleModel> sales;
    int _username = _prefs.userId;

    return Scaffold(
      appBar: _appBar(context),
      body: FutureBuilder(
        future: _salesProvider.getSalesByUser(
            widget.category.id, _username, widget.startDate, widget.endDate),
        builder:
            (BuildContext context, AsyncSnapshot<List<SaleModel>> snapshot) {
          if (snapshot.hasData) {
            sales = snapshot.data;

            if (sales.isNotEmpty) {
              List<Widget> salesWidgets = sales
                  .asMap()
                  .entries
                  .map((entry) => _saleCard(entry.value, sales, entry.key))
                  .toList();
              double total = sales.map((e) => e.value).reduce((a, b) => a + b);
              String formattedTotal = currencyFormat.format(total);
              String formattedPoints = pointsFormat.format(total / 1000);

              return Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    ...salesWidgets,
                    _totalWidget(context, formattedTotal, formattedPoints)
                  ],
                ),
              );
            } else {
              return _emptySales(context);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Card _totalWidget(
      BuildContext context, String formattedTotal, String formattedPoints) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      color: MiPromotora().accent,
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
                Text(
                  formattedTotal,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total puntos',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
                Text(
                  formattedPoints,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _emptySales(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.8,
        padding: EdgeInsets.all(10),
        child: Text(
            "No tienes ventas asociadas de esta categoría desde la fecha seleccionada (${widget.startDate})",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black)),
      ),
    );
  }

  Widget _saleCard(SaleModel sale, List<SaleModel> sales, int index) {
    final String created = dateFormat.format(sale.date);
    final String price = currencyFormat.format(sale.value);
    return Dismissible(
      key: Key(sale.id.toString()),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Card(
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(created),
                            Text(price),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cliente"),
                            Text(sale.client),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Identificación"),
                            Text(sale.idClient),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ID venta"),
                            Text(sale.id.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () async {
                      bool deleted = await _deleteSale(sale);
                      if (deleted) {
                        setState(() {
                          sales.removeAt(index);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _deleteSale(SaleModel sale) async {
    bool deleted = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Borrar venta",
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
          ),
          content: Text("¿Desea borrar la venta con ID: ${sale.id}?"),
          actions: <Widget>[
            TextButton(
                child: Text(
                  'Cancelar',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: MiPromotora().primaryDark, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: Text(
                'Borrar',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.red, fontSize: 16),
              ),
              onPressed: () async {
                deleted = await _salesProvider.deleteSale(sale);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );

    return deleted;
  }
}
