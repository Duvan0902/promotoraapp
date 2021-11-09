import 'dart:ui';

import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mi_promotora/common/formats.dart';
import 'package:mi_promotora/common/historic_chart.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/goals_model.dart';
import 'package:mi_promotora/pages/ranking_page.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import "package:intl/intl.dart";

class GoalInformationPage extends StatefulWidget {
  final GoalsModel goals;
  GoalInformationPage({Key key, this.goals}) : super(key: key);

  @override
  _GoalInformationPageState createState() => _GoalInformationPageState();
}

class _GoalInformationPageState extends State<GoalInformationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          _title(context),
          SizedBox(height: 20),
          _progressBarBudget(),
          SizedBox(height: 10),
          _historicChart(context),
          SizedBox(height: 10),
          _progressBar(),
          SizedBox(height: 10),
          _top10(),
          SizedBox(height: 10),
          _cirleGraph(),
          SizedBox(height: 10),
          _weightValue(),
          SizedBox(height: 15),
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
    double pdnNew = double.tryParse(widget.goals.pdnNew);
    double goal = double.tryParse(widget.goals.goal);
    double totalPercentagePdnNew = (100 * pdnNew / goal);

    String formattedGoal = NumberFormat.compactSimpleCurrency().format(goal);

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
              'Tu presupuesto mensual',
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
                Text(currencyFormat.format(0)),
                Text(formattedGoal),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _historicChart(BuildContext context) {
    return HistoricChart();
  }

  Widget _progressBar() {
    var goalValue = widget.goals.goal;
    var avgPrima = widget.goals.avgPrima;
    var pdnNew = widget.goals.pdnNew;
    double covertNumberPdnNew = double.parse(pdnNew);
    double covertNumberGoal = double.parse(goalValue);
    double covertNumberAvgPrima = avgPrima != "0" ? double.parse(avgPrima) : 1;
    int leaflet =
        (covertNumberGoal / (widget.goals.pctEffect * covertNumberAvgPrima))
            .ceil();
    double totalPercentageLeaflet =
        (100 * (covertNumberPdnNew / covertNumberAvgPrima) / leaflet);

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
    var pdnTotal = double.parse(widget.goals.pdnTotal);
    var pndNew = double.parse(widget.goals.pdnNew);
    var totalPercentagePdnNew = (100 * pndNew / pdnTotal).round();
    var totalPercentagePdnOthers =
        (100 * (pdnTotal - pndNew) / pdnTotal).round();

    Map<String, double> dataMap = {
      "Pdn. Nueva": pndNew,
      "Total": pdnTotal - pndNew
    };

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            pie.PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 2.8,
              initialAngleInDegree: 0,
              colorList: [Colors.blue, Colors.indigo[700]],
              ringStrokeWidth: 40,
              legendOptions: pie.LegendOptions(
                showLegendsInRow: false,
                legendPosition: pie.LegendPosition.bottom,
                showLegends: false,
                legendShape: BoxShape.circle,
              ),
              chartValuesOptions: pie.ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  chartValueStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 17)),
            ),
            Flexible(
                child: Column(
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
                  'y Otros',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 17),
                ),
                SizedBox(height: 20),
                Text(
                  ('Produccion Nueva: $totalPercentagePdnNew %'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black45, fontSize: 14),
                ),
                Text(
                  ('Otros: $totalPercentagePdnOthers %'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black45, fontSize: 14),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _top10() {
    return Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.fromLTRB(20, 10, 10, 10)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
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
                color: MiPromotora().primaryDark,
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RankingPage()),
          );
        },
      ),
    );
  }

  Widget _weightValue() {
    double total = double.tryParse(widget.goals.pdnTotal);
    double cancelled = double.tryParse(widget.goals.pdnCanc);

    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          child: Container(
            width: size.width * 0.47,
            height: size.width * 0.45,
            child: Card(
              color: MiPromotora().primaryDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Text(
                    currencyFormat.format(cancelled.abs()),
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
        ),
        SizedBox(width: 4),
        Flexible(
          child: Container(
            width: size.width * 0.47,
            height: size.width * 0.45,
            child: Card(
              color: Colors.cyan[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Text(
                    currencyFormat.format(total),
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
        ),
      ],
    );
  }
}
