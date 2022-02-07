import 'dart:convert';

import 'package:demo_youtube/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:demo_youtube/models/medicionModel.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<MedicionModel> _datosGrafico = [];
  // List<Medicion> datosGrafico = [
  //   Medicion("2022-02-06T16:01:45.931Z", 80),
  //   Medicion("2022-02-06T16:02:46.931Z", 85),
  //   Medicion("2022-02-06T16:03:45.931Z", 90),
  //   Medicion("2022-02-06T16:04:45.931Z", 75),
  //   Medicion("2022-02-06T16:05:45.931Z", 80),
  //   Medicion("2022-02-06T16:06:45.931Z", 80),
  //   Medicion("2022-02-06T16:07:45.931Z", 80),
  //   Medicion("2022-02-06T16:08:45.931Z", 80),
  // ];

  // List<Medicion> getMediciones() {
  //   datosGrafico;
  //   return datosGrafico;
  // }

  List<MedicionModel> datosGrafico2 = [];
  // List<Medicion> datosGrafico2 = [
  //   Medicion("2022-02-06T16:01:45.931Z", 80),
  //   Medicion("2022-02-06T16:02:46.931Z", 85),
  //   Medicion("2022-02-06T16:03:45.931Z", 90),
  //   Medicion("2022-02-06T16:04:45.931Z", 75),
  //   Medicion("2022-02-06T16:05:45.931Z", 80),
  //   Medicion("2022-02-06T16:06:45.931Z", 80),
  //   Medicion("2022-02-06T16:07:45.931Z", 80),
  //   Medicion("2022-02-06T16:08:45.931Z", 80),
  // ];

  // List<Medicion> getMediciones2() {
  //   datosGrafico2;
  //   return datosGrafico2;
  // }

  int responseStatus = 400;
  String response = "";

  int? sortColumnIndex;
  bool isAscending = false;

  MedicionModel medicionModel = MedicionModel();
  List<MedicionModel> listMedicionModel = [];

  String date = '';

  Widget TablaDatos2(List<MedicionModel> listMedicionModel) {
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
          rows: getRows(listMedicionModel),
        ),
      ],
    );
  }

  List<DataRow> getRows(List<MedicionModel> mediciones) =>
      mediciones.map((MedicionModel medicion) {
        final cells = [medicion.dia, medicion.medida];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  int _compareDouble(bool ascending, num dia, num dia2) =>
      ascending ? dia.compareTo(dia2) : dia2.compareTo(dia);

  int _compareString(bool ascending, String dia, String dia2) =>
      ascending ? dia.compareTo(dia2) : dia2.compareTo(dia);

  void _onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      listMedicionModel.sort((medicion1, medicion2) =>
          _compareString(ascending, medicion1.dia!, medicion2.dia!));
    } else if (columnIndex == 1) {
      listMedicionModel.sort((medicion1, medicion2) =>
          _compareDouble(ascending, medicion1.medida!, medicion2.medida!));
      //si necesito enviar numeros en lugar de string, puedo '${variable.atributo}'
    }

    // int _compareString(bool ascending, double dia, double dia2) =>
    //     ascending ? dia.compareTo(dia2) : dia2.compareTo(dia);

    // void _onSort(int columnIndex, bool ascending) {
    //   if (columnIndex == 0) {
    //     datosGrafico2.sort((medicion1, medicion2) =>
    //         _compareString(ascending, medicion1.dia, medicion2.dia));
    //   } else if (columnIndex == 1) {
    //     datosGrafico2.sort((medicion1, medicion2) =>
    //         _compareString(ascending, medicion1.medida, medicion2.medida));
    //     //si necesito enviar numeros en lugar de string, puedo '${variable.atributo}'
    //   }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  @override
  void initState() {
    // _datosGrafico = getMediciones();
    // _datosGrafico2 = getMediciones2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Tabla(),
        BotonSeleFecha(),
        Expanded(child: TablaDatos2(listMedicionModel)),
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
        primaryXAxis: CategoryAxis(),
        //legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<MedicionModel, String>(
            name: "Historial Mediciones",
            dataSource: _datosGrafico,
            xValueMapper: (MedicionModel med, _) => med.dia,
            yValueMapper: (MedicionModel med, _) => med.medida,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
            enableTooltip: true,
          ),
        ],
        //primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
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
        ).then((DateTime? value) async {
          if (value != null) {
            DateTime _fromDate = DateTime.now();
            _fromDate = value;
            date = DateFormat('yyyy-MM-dd').format(_fromDate);
            date = date.toString();
            response = await Search(date);
            List jsonMedicion = jsonDecode(response);
            print('Lista de mediciones $jsonMedicion');
            setState(() {
              listMedicionModel = jsonMedicion
                  .map((medida) => MedicionModel(
                        id: medida['id'],
                        medida: medida['measurement'],
                        dia: medida['measure_date'],
                        user_id: medida['user_id'],
                      ))
                  .toList();
            });
            print('ID:     ${listMedicionModel[1].id}');
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

  Future<String> Search(String date) async {
    String respuesta;
    final String CadenaConexion = 'http://localhost:8080/measure/search';
    int idN = AppProvider().userModel.id!;
    var json = {'userId': idN, 'date': date};
    final response = await http.post(Uri.parse(CadenaConexion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(json));

    if (response.statusCode == 200) {
      responseStatus = response.statusCode;
      respuesta = response.body;
      //return LoginModel.fromJson(jsonDecode(response.body));
      return response.body;
    } else {
      responseStatus = response.statusCode;
      throw Exception('Failed to search date.');
    }
  }
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



