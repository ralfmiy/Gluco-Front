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

  List<Medicion> getMediciones() {
    datosGrafico;
    return datosGrafico;
  }

  late List<Medicion> _datosGrafico2;
  List<Medicion> datosGrafico2 = [
    Medicion(1, 80),
    Medicion(2, 85),
    Medicion(3, 90),
    Medicion(4, 75),
    Medicion(6, 80),
    Medicion(7, 80),
    Medicion(8, 80),
    Medicion(9, 80),
  ];

  List<Medicion> getMediciones2() {
    datosGrafico2;
    return datosGrafico2;
  }

  int? sortColumnIndex;
  bool isAscending = false;

  Widget TablaDatos2(List<Medicion>   datosGrafico2) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DataTable(
          sortAscending: isAscending,
          sortColumnIndex: sortColumnIndex,
          columns: [
            DataColumn(
              label: Text("Hora"),
              onSort: _onSort,
            ),
            DataColumn(
              label: Text("Medición"),
              onSort: _onSort,
            ),
          ],
          rows: getRows(datosGrafico2),
        ),
      ],
    );
  }

  List<DataRow> getRows(List<Medicion> mediciones) =>
      mediciones.map((Medicion medicion) {
        final cells = [medicion.dia, medicion.medida];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  int _compareString(bool ascending, double dia, double dia2) =>
      ascending ? dia.compareTo(dia2) : dia2.compareTo(dia);

  void _onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      datosGrafico2.sort((medicion1, medicion2) =>
          _compareString(ascending, medicion1.dia, medicion2.dia));
    } else if (columnIndex == 1) {
      datosGrafico2.sort((medicion1, medicion2) =>
          _compareString(ascending, medicion1.medida, medicion2.medida));
      //si necesito enviar numeros en lugar de string, puedo '${variable.atributo}'
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  @override
  void initState() {
    _datosGrafico = getMediciones();
    _datosGrafico2 = getMediciones2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Tabla(),
        BotonSeleFecha(),
        Expanded(child: TablaDatos2(_datosGrafico2)),
      ],
    );
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

// Widget TablaDatos(List<Medicion> datosGrafico) {
//   return ListView.builder(
//     itemCount: datosGrafico.length,
//     itemBuilder: (context, index) {
//       return Text(datosGrafico[index].dia.toString() +
//           "----" +
//           datosGrafico[index].medida.toString());
//     },
//   );
// }



