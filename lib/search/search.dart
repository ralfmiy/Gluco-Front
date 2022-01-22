import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late List<Medicion> _datosGrafico;

  @override
  void initState() {
    _datosGrafico = getMediciones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Tabla(),
        BotonSeleFecha(),
      ],
    );
  }

  List<Medicion> getMediciones() {
    List<Medicion> datosGrafico = [
      Medicion(1, 80),
      Medicion(2, 85),
      Medicion(3, 90),
      Medicion(4, 75),
      Medicion(6, 80),
      Medicion(7, 80),
      Medicion(8, 80),
      Medicion(9, 80),
    ];
    return datosGrafico;
  }

  Widget Tabla() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.40,
      child: SfCartesianChart(
        title: ChartTitle(text: "Mediciones"),
        //legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<Medicion, double>(
            name: "Historial Mediciones",
            dataSource: _datosGrafico,
            xValueMapper: (Medicion med, _) => med.dia,
            yValueMapper: (Medicion med, _) => med.medida,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
            enableTooltip: true,
          ),
        ],
        primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
      ),
    );
  }

  Widget BotonSeleFecha() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blue[600],
          fixedSize: Size(MediaQuery.of(context).size.width * 0.65, 45)),
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2018),
          lastDate: DateTime.now(),
        ).then((DateTime? value) {
          if (value != null) {
            DateTime _fromDate = DateTime.now();
            _fromDate = value;
            final String date = DateFormat.yMMMd().format(_fromDate);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Día seleccionado: $date'),
                duration: Duration(milliseconds: 1500),
              ),
            );
          }
        });
      },
      child: const Text(
        'Seleccione una fecha',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Medicion {
  Medicion(this.dia, this.medida);
  final double dia;
  final double medida;
}

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// /// Data class to visualize.
// class _SalesData {
//   final int year;
//   final int sales;

//   _SalesData(this.year, this.sales);
//   // Returns Jan.1st of that year as date.
//   DateTime get date => DateTime(this.year);
// }

// /// Generate some random data.
// List<_SalesData> _genRandData() {
//   final random = Random();
//   // Returns an increasing series with some fluctuations.
//   return [
//     for (int i = 2005; i < 2020; ++i)
//       _SalesData(i, (i - 2000) * 40 + random.nextInt(100)),
//   ];
// }

// class Search extends StatefulWidget {
//   const Search({Key? key}) : super(key: key);

//   @override
//   _TimeseriesChartExampleState createState() => _TimeseriesChartExampleState();
// }

// class _TimeseriesChartExampleState extends State<Search> {
//   bool _animate = true;
//   bool _defaultInteractions = true;
//   bool _includeArea = true;
//   bool _includePoints = true;
//   bool _stacked = true;
//   charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
//   charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.bottom;

//   // Data to render.
//   late List<_SalesData> _series1, _series2;

//   @override
//   void initState() {
//     super.initState();
//     this._series1 = _genRandData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         SizedBox(
//           height: 300,
//           child: charts.TimeSeriesChart(
//             /*seriesList=*/ [
//               charts.Series<_SalesData, DateTime>(
//                 id: 'Sales-1',
//                 colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//                 domainFn: (_SalesData sales, _) => sales.date,
//                 measureFn: (_SalesData sales, _) => sales.sales,
//                 data: this._series1,
//               ),
//               charts.Series<_SalesData, DateTime>(
//                 id: 'Sales-2',
//                 colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//                 domainFn: (_SalesData sales, _) => sales.date,
//                 measureFn: (_SalesData sales, _) => sales.sales,
//                 data: this._series2,
//               ),
//             ],
//             defaultInteractions: this._defaultInteractions,
//             defaultRenderer: charts.LineRendererConfig(
//               includePoints: this._includePoints,
//               includeArea: this._includeArea,
//               stacked: this._stacked,
//             ),
//             animate: this._animate,
//             behaviors: [
//               // Add title.
//               charts.ChartTitle(
//                 'Dummy sales time series',
//                 behaviorPosition: _titlePosition,
//               ),
//               // Add legend.
//               charts.SeriesLegend(position: _legendPosition),
//               // Highlight X and Y value of selected point.
//               charts.LinePointHighlighter(
//                 showHorizontalFollowLine:
//                     charts.LinePointHighlighterFollowLineType.all,
//                 showVerticalFollowLine:
//                     charts.LinePointHighlighterFollowLineType.nearest,
//               ),
//             ],
//           ),
//         ),
//         const Divider(),
//         ..._controlWidgets(),
//       ],
//     );
//   }

//   /// Widgets to control the chart appearance and behavior.
//   List<Widget> _controlWidgets() => <Widget>[
//         SwitchListTile(
//           title: const Text('animate'),
//           onChanged: (bool val) => setState(() => this._animate = val),
//           value: this._animate,
//         ),
//         SwitchListTile(
//           title: const Text('defaultInteractions'),
//           onChanged: (bool val) =>
//               setState(() => this._defaultInteractions = val),
//           value: this._defaultInteractions,
//         ),
//         SwitchListTile(
//           title: const Text('includePoints'),
//           onChanged: (bool val) => setState(() => this._includePoints = val),
//           value: this._includePoints,
//         ),
//         SwitchListTile(
//           title: const Text('includeArea'),
//           onChanged: (bool val) => setState(() => this._includeArea = val),
//           value: this._includeArea,
//         ),
//         SwitchListTile(
//           title: const Text('stacked'),
//           onChanged: (bool val) => setState(() => this._stacked = val),
//           value: this._stacked,
//         ),
//         ListTile(
//           title: const Text('titlePosition:'),
//           trailing: DropdownButton<charts.BehaviorPosition>(
//             value: this._titlePosition,
//             onChanged: (charts.BehaviorPosition? newVal) {
//               if (newVal != null) {
//                 setState(() => this._titlePosition = newVal);
//               }
//             },
//             items: [
//               for (final val in charts.BehaviorPosition.values)
//                 DropdownMenuItem(value: val, child: Text('$val'))
//             ],
//           ),
//         ),
//         ListTile(
//           title: const Text('legendPosition:'),
//           trailing: DropdownButton<charts.BehaviorPosition>(
//             value: this._legendPosition,
//             onChanged: (charts.BehaviorPosition? newVal) {
//               if (newVal != null) {
//                 setState(() => this._legendPosition = newVal);
//               }
//             },
//             items: [
//               for (final val in charts.BehaviorPosition.values)
//                 DropdownMenuItem(value: val, child: Text('$val'))
//             ],
//           ),
//         ),
//       ];
// }
