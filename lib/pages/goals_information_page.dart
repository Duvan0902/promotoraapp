import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/models/goals_model.dart';
import 'package:promotoraapp/pages/top_ten_page.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class GoaldInformationPage extends StatefulWidget {
  final GoalsModel goasl;
  GoaldInformationPage({Key key, this.goasl}) : super(key: key);

  @override
  _GoaldInformationPageState createState() => _GoaldInformationPageState();
}

class _GoaldInformationPageState extends State<GoaldInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          _title(context),
          SizedBox(
            height: 20,
          ),
          _progressBar(),
          SizedBox(
            height: 10,
          ),
          _cirleGraph(),
          SizedBox(
            height: 10,
          ),
          _top10(),
          SizedBox(
            height: 10,
          ),
          _weightValue(),
        ],
      ),
    );
  }

  Widget _title(context) {
    return Text(
      '¡Esperamos que tengas excelentes ventas! A continuación te presentamos las metas del mes.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.white, fontSize: 17),
    );
  }

  Widget _progressBar() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text('Cantidad de clientes que debes visitar este mes.'),
            RoundedProgressBar(
              style: RoundedProgressBarStyle(
                borderWidth: 0,
                widthShadow: 0,
                backgroundProgress: Color.fromRGBO(243, 243, 243, 1),
                colorProgress: Colors.pink,
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              borderRadius: BorderRadius.circular(20),
              percent: 40,
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('0'),
                Text('30'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cirleGraph() {
    Map<String, double> dataMap = {
      "Flutter": 55,
      "React": 45,
    };

    PieChart(dataMap: dataMap);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 2.5,
              initialAngleInDegree: 0,
              ringStrokeWidth: 40,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: false,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Producción Nueva',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 17),
                ),
                Text(
                  'VS Cancelaciones',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 17),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Produccion Nueva: 55%',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black45, fontSize: 14),
                ),
                Text(
                  'Cancelaciones 45%',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black45, fontSize: 14),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _top10() {
    return Container(
      padding: EdgeInsets.all(5),
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Revisa el Top 10',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black, fontSize: 15.1),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                color: PromotoraApp().primaryDark,
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
        ),
        color: Colors.white,
        disabledTextColor: Colors.grey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TopTenPage()),
          );
        },
      ),
    );
  }

  Widget _weightValue() {
    return Row(
      children: <Widget>[
        Container(
          width: 170,
          height: 160,
          child: Card(
            color: PromotoraApp().primaryDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '' + widget.goasl.pdnCanc,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Cancelación',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Container(
          width: 170,
          height: 160,
          child: Card(
            color: Colors.cyan[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '' + widget.goasl.pdnTotal,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Producción Total',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
