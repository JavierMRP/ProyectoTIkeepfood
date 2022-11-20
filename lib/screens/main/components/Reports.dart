import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../constants.dart';
import 'package:keepfood/screens/dashboard/components/file_info_card.dart';
import 'package:keepfood/responsive.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: defaultPadding),
          Responsive(
            mobile: FileInfoCardGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
            ),
            tablet: FileInfoCardGridView(),
            desktop: FileInfoCardGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    List<int> lista = [0, 1, 2, 3];
    return GridView.builder(
        padding: EdgeInsets.all(20.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) =>
            carta(context, salesPerMonth(lista[index]), crossAxisCount));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class LineData {
  LineData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class DonutData {
  DonutData(this.x, this.y);
  final String x;
  final double y;
}

salesPerMonth(int index) {
  List<DonutData> dataDonut = [
    DonutData('David', 25),
    DonutData('Steve', 38),
    DonutData('Jack', 34),
    DonutData('Others', 52)
  ];
  TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  List<ChartData> pieData = [
    ChartData('David', 25, Color.fromARGB(216, 230, 42, 42)),
    ChartData('Steve', 38, Color.fromARGB(215, 42, 86, 230)),
    ChartData('Jack', 34, Color.fromARGB(214, 234, 238, 13)),
    ChartData('Others', 52, Color.fromARGB(214, 140, 13, 214))
  ];
  List<LineData> chartData = [
    LineData(DateTime(2010), 35),
    LineData(DateTime(2011), 28),
    LineData(DateTime(2012), 34),
  ];
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  if (index == 0)
    return SfSparkLineChart.custom(
      //Enable the trackball
      trackball:
          SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
      //Enable marker
      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.all,
      xValueMapper: (int index) => data[index].year,
      yValueMapper: (int index) => data[index].sales,
      dataCount: 5,
    );
  if (index == 1)
    return SfCartesianChart(primaryXAxis: DateTimeAxis(), series: <ChartSeries>[
      // Renders line chart
      LineSeries<LineData, DateTime>(
          dataSource: chartData,
          xValueMapper: (LineData sales, _) => sales.year,
          yValueMapper: (LineData sales, _) => sales.sales)
    ]);
  if (index == 2) {
    return SfCircularChart(series: <CircularSeries>[
      // Render pie chart
      PieSeries<ChartData, String>(
        dataSource: pieData,
        name: "hola",
        pointColorMapper: (ChartData data, _) => data.color,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        dataLabelSettings: DataLabelSettings(
            isVisible: true, overflowMode: OverflowMode.shift),
      )
    ]);
  }
  if (index == 3) {
    return SfCircularChart(series: <CircularSeries>[
      // Renders radial bar chart
      RadialBarSeries<DonutData, String>(
        dataSource: dataDonut,
        xValueMapper: (DonutData data, _) => data.x,
        yValueMapper: (DonutData data, _) => data.y,
        dataLabelSettings: DataLabelSettings(
            // Renders the data label
            isVisible: true),
        useSeriesColor: true,
        trackOpacity: 0.3,
      )
    ]);
  }
}

Container carta(BuildContext context, Widget chart, int crossAxis) {
  return Container(
    padding: EdgeInsets.all(defaultPadding),
    decoration: BoxDecoration(
      color: secondaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Ventas por mes",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Container(height: crossAxis == 2 ? 90 : 150, child: chart),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " Platos",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.black),
            ),
            Text(
              "info.totalStorage",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.black),
            ),
          ],
        )
      ],
    ),
  );
}
