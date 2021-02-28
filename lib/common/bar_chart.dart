import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 32),
    _SalesData('Jun', 32),
    _SalesData('Jul', 32),
    _SalesData('Aug', 32),
    _SalesData('Sep', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child:
            //Initialize the chart widget
            SfCartesianChart(
          primaryXAxis: CategoryAxis(),
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
          series: <ChartSeries<_SalesData, String>>[
            ColumnSeries<_SalesData, String>(
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Lo que llevas',
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: false),
              color: Colors.blue,
            ),
            ColumnSeries<_SalesData, String>(
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Lo que debes alcanzar',
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: false),
              color: Colors.yellow[600],
            )
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
