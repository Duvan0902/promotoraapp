import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_promotora/models/goals_model.dart';
import 'package:mi_promotora/providers/goals_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoricChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoricChartState();
}

class HistoricChartState extends State<HistoricChart> {
  @override
  Widget build(BuildContext context) {
    GoalsProvider goalsProvider = GoalsProvider();
    DateTime currentDate = DateTime.now();
    DateTime initialDate = currentDate.subtract(Duration(days: 30 * 6));

    return FutureBuilder(
      future: goalsProvider.getHistoric(initialDate),
      builder:
          (BuildContext context, AsyncSnapshot<List<GoalsModel>> snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          if (snapshot.hasData) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: _historicChart(snapshot.data),
            );
          } else {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "No se ha podido obtener los datos históricos para este usuario.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
            );
          }
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

  Widget _historicChart(List<GoalsModel> data) {
    return Container(
      padding: EdgeInsets.all(10),
      child:
          //Initialize the chart widget
          SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelRotation: -45,
        ),
        primaryYAxis: NumericAxis(
          numberFormat:
              NumberFormat.compactSimpleCurrency(name: 'COP', locale: 'es'),
        ),
        // Chart title
        title: ChartTitle(
          text: 'Tus logros con respecto a tus metas mensuales',
          textStyle: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.black, fontSize: 14),
          alignment: ChartAlignment.center,
        ),
        // Enable legend
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<GoalsModel, String>>[
          ColumnSeries<GoalsModel, String>(
            dataSource: data,
            xValueMapper: (GoalsModel goal, _) =>
                DateFormat('MMM').format(goal.reportDate),
            yValueMapper: (GoalsModel goal, _) =>
                double.tryParse(goal.pdnMonthly),
            name: 'Lo que llevas',
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: false),
            color: Colors.blue,
          ),
          ColumnSeries<GoalsModel, String>(
            dataSource: data,
            xValueMapper: (GoalsModel goal, _) =>
                DateFormat('MMM').format(goal.reportDate),
            yValueMapper: (GoalsModel goal, _) => double.tryParse(goal.goal),
            name: 'Tu meta',
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: false),
            color: Colors.yellow[600],
          )
        ],
      ),
    );
  }
}
