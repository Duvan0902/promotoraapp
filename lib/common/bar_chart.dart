import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_promotora/models/goals_model.dart';
import 'package:mi_promotora/providers/goals_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {
  @override
  Widget build(BuildContext context) {
    GoalsProvider goalsProvider = GoalsProvider();
    final size = MediaQuery.of(context).size;
    DateTime currentDate = DateTime.now();
    DateTime initialDate = currentDate.subtract(Duration(days: 30 * 6));

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FutureBuilder(
        future: goalsProvider.getHistoric(initialDate),
        builder:
            (BuildContext context, AsyncSnapshot<List<GoalsModel>> snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              return _historicChart(snapshot.data);
            } else {
              return Center(
                child: Container(
                  width: size.width * 0.6,
                  child: Text(
                    "No se ha podido obtener la información asociada al usuario",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
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
      ),
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
          text: 'Tus logros con respecto a tus metas anuales',
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
            yValueMapper: (GoalsModel goal, _) => double.tryParse(goal.pdnNew),
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
            name: 'Lo que falta',
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: false),
            color: Colors.yellow[600],
          )
        ],
      ),
    );
  }
}
