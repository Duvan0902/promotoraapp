import 'package:mi_promotora/providers/sales_provider.dart';
import 'package:flutter/material.dart';
import 'package:mi_promotora/models/goals_model.dart';
import 'package:mi_promotora/pages/sale_page.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/providers/goals_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:global_configuration/global_configuration.dart';
import "package:intl/intl.dart";

class ManagementPage extends StatefulWidget {
  final GoalsModel goal;
  const ManagementPage({Key key, this.goal}) : super(key: key);

  @override
  _ManagementPageState createState() => _ManagementPageState();
}

final String _url = GlobalConfiguration().getValue("api_url");

class _ManagementPageState extends State<ManagementPage> {
  int currentSales = 0;

  int avgPrima = 0;
  int goalSales = 0;
  String downloadUrl;

  getInitialData() async {
    GoalsProvider goalsProvider = GoalsProvider();
    SalesProvider salesProvider = SalesProvider();

    GoalsModel goals = await goalsProvider.getGoal();
    int sales = await salesProvider.getSalesCount();
    print("Data: " + goals.avgPrima);
    print("Sales: " + sales.toString());

    String url = goals.integratedReport.file.url;

    setState(() {
      this.currentSales = sales;
      this.goalSales = int.tryParse(goals.goal) ?? 0;
      this.avgPrima = int.tryParse(goals.avgPrima) ?? 0;

      this.downloadUrl = url;
    });
  }

  @override
  initState() {
    super.initState();
    getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: MiPromotora().grey,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          _title(context),
          SizedBox(
            height: 30,
          ),
          _progressIndicator(context),
          SizedBox(
            height: 20,
          ),
          _addSaleButton(context),
        ],
      ),
    );
  }

  Widget _title(context) {
    return Text(
      'Registra cada una de las metas que realices en el mes, así podrás llevar el control de tus metas.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.white, fontSize: 17),
    );
  }

  Widget _progressIndicator(context) {
    var value = this.avgPrima != 0 && this.avgPrima != null
        ? this.goalSales / this.avgPrima
        : 0;

    return Card(
      margin: EdgeInsets.all(0),
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.pink, width: 3),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 1,
                child: Center(
                  child: Container(
                    child: _percentagelist(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Números de ventas',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        'Cuantas llevo: ' + this.currentSales.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black45, fontSize: 15),
                      ),
                      Text(
                        ('Cuantas me faltan: ' + value.ceil().toString()),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black45, fontSize: 15),
                      ),
                    ],
                  ),
                  _downloadButton(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _percentagelist() {
    var goalSales = this.goalSales;
    var currentSales = this.currentSales;
    var avgPrima = this.avgPrima;
    var totalValue = (goalSales / avgPrima).floorToDouble();
    var totalPercentage =
        totalValue != 0 ? ((100 * currentSales) / totalValue) : 0;
    var finalvalue = NumberFormat("#,##0.00").format(totalPercentage);

    return Container(
      child: Text(
        '$finalvalue%',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black, fontSize: 28),
      ),
    );
  }

  Widget _downloadButton(context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(MiPromotora().primaryDark),
      ),
      onPressed: () => _launchURL(this.downloadUrl),
      child: Text(
        "Descargar reporte",
        style: TextStyle(fontSize: 17.0),
      ),
    );
  }
}

Widget _addSaleButton(context) {
  return ElevatedButton(
    child: Container(
      child: Text(
        'Agregar mi venta',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(color: Colors.black, fontSize: 17),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SalePage(),
        ),
      );
    },
  );
}

_launchURL(url) async {
  if (await canLaunch(_url + url)) {
    await launch(_url + url);
  } else {
    throw 'Could not launch $url';
  }
}
