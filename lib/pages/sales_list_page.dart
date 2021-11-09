import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_promotora/common/formats.dart';
import 'package:mi_promotora/common/sale_item.dart';
import 'package:mi_promotora/models/sales_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/sales_provider.dart';

import '../main.dart';

class SalesListPage extends StatefulWidget {
  final SalesCategoryModel category;
  final String startDate;
  final String endDate;

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
      ),
      body: FutureBuilder(
        future: _salesProvider.getSalesByUser(
            widget.category.id, _username, widget.startDate, widget.endDate),
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
                    final String price = currencyFormat.format(sale.value);

                    return FlexibleExpansionCard(
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(created),
                          Text(price),
                        ],
                      ),
                      detail: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Cliente"),
                                    Text(sale.client),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Identificación"),
                                    Text(sale.idClient),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: IconButton(
                              onPressed: () async {
                                bool deleted = await _deleteSale(sale);
                                if (deleted) {
                                  setState(() {});
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
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
                      "No tienes ventas asociadas de esta categoría desde la fecha seleccionada (${widget.startDate})",
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
