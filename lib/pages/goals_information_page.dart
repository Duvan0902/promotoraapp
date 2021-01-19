import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/models/goals_model.dart';
import 'package:promotoraapp/pages/top_ten_page.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import "package:intl/intl.dart";

class GoaldInformationPage extends StatefulWidget {
  final GoalsModel goasl;
  GoaldInformationPage({Key key, this.goasl}) : super(key: key);

  @override
  _GoaldInformationPageState createState() => _GoaldInformationPageState();
}

String sign = "\$";

class _GoaldInformationPageState extends State<GoaldInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          _title(context),
          SizedBox(height: 20),
          _progressBarBudget(),
          SizedBox(height: 10),
          _progressBar(),
          SizedBox(height: 10),
          _top10(),
          SizedBox(height: 10),
          _cirleGraph(),
          SizedBox(height: 10),
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

  Widget _progressBarBudget() {
    var pdnNew = widget.goasl.pdnNew;
    var covertNumberPdnNew = double.parse(pdnNew);
    var totalPercentage = widget.goasl.goal;
    var convertNumberGoal = double.parse(totalPercentage);
    var totalPercentagePdnNew = (100 * covertNumberPdnNew / convertNumberGoal);
    var newNamberGoal = NumberFormat.decimalPattern().format(convertNumberGoal);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Presupuesto mensual.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 10),
            RoundedProgressBar(
              style: RoundedProgressBarStyle(
                borderWidth: 0,
                widthShadow: 0,
                backgroundProgress: Color.fromRGBO(243, 243, 243, 1),
                colorProgress: Colors.pink,
              ),
              margin: EdgeInsets.symmetric(vertical: 5),
              borderRadius: BorderRadius.circular(20),
              percent: totalPercentagePdnNew,
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(sign + '0'),
                Text(sign + newNamberGoal),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _progressBar() {
    var goalValue = widget.goasl.goal;
    var avgPrima = widget.goasl.avgPrima;
    var pdnNew = widget.goasl.pdnNew;
    var covertNumberPdnNew = double.parse(pdnNew);
    var covertNumberGoal = double.parse(goalValue);
    var covertNumberAvgPrima = double.parse(avgPrima);
    var leaflet =
        (covertNumberGoal / (widget.goasl.pctEffect * covertNumberAvgPrima))
            .ceil();
    var totalPercentageLeaflet =
        (100 * (covertNumberPdnNew / covertNumberAvgPrima) / leaflet);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
        child: Column(
          children: <Widget>[
            Text(
              'Cantidad de clientes que debes visitar este mes.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 10),
            RoundedProgressBar(
              style: RoundedProgressBarStyle(
                borderWidth: 0,
                widthShadow: 0,
                backgroundProgress: Color.fromRGBO(243, 243, 243, 1),
                colorProgress: Colors.pink,
              ),
              margin: EdgeInsets.symmetric(vertical: 5),
              borderRadius: BorderRadius.circular(20),
              percent: totalPercentageLeaflet,
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('0'),
                Text('$leaflet'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cirleGraph() {
    var total = widget.goasl.pdnNewPrev;
    var cancel = widget.goasl.pdnCanc;
    var pndNewPrev = double.parse(total);
    var pdnCanc = double.parse(cancel).abs();
    var totalPercentage = pndNewPrev + pdnCanc;
    var totalPercentagePdnNewPrev = (100 * pndNewPrev / totalPercentage).ceil();
    var totalPercentagePdnCanc = (100 * pdnCanc / totalPercentage).floor();

    Map<String, double> dataMap = {
      "Flutter": pndNewPrev,
      "React": pdnCanc,
    };

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 2.8,
              initialAngleInDegree: 0,
              colorList: [Colors.blue, Colors.indigo[700]],
              ringStrokeWidth: 40,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: false,
                legendShape: BoxShape.circle,
              ),
              chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  chartValueStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 17)),
            ),
            SizedBox(width: 10),
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
                SizedBox(height: 20),
                Text(
                  ('Produccion Nueva: $totalPercentagePdnNewPrev %'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black45, fontSize: 14),
                ),
                Text(
                  'Cancelaciones: $totalPercentagePdnCanc%',
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
    var total = widget.goasl.pdnTotal;
    var changeTotal = int.parse(total).ceil();
    var finaldataTotal = NumberFormat.decimalPattern().format(changeTotal); //

    var cancel = widget.goasl.pdnCanc;
    var changeCancel = int.parse(cancel).abs().ceil();

    var finaldataCancel = NumberFormat.decimalPattern().format(changeCancel);
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
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  sign + finaldataCancel,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 22),
                ),
                SizedBox(height: 20),
                Text(
                  'Cancelación',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 4),
        Container(
          width: 170,
          height: 160,
          child: Card(
            color: Colors.cyan[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  (sign + finaldataTotal),
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Producción Total',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 20),
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
