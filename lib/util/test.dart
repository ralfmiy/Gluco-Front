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
  int responseStatus = 400;
  String response = "";
  String date = '';
  DateTime fechaValue = DateTime.now();

  int? sortColumnIndex;
  bool isAscending = false;

  MedicionModel medicionModel = MedicionModel();
  List<MedicionModel> listMedicionModel = [];
  List<MedicionModel> listMedicionModelGrafico = [];

  Widget TablaDatos2(List<MedicionModel> listMedicionModel) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DataTable(
          sortAscending: isAscending,
          sortColumnIndex: sortColumnIndex,
          columns: [
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text("Hora",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              onSort: _onSort,
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text(
                    "Medición",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
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

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(Center(
            child: Text(
              '$data',
            ),
          )))
      .toList();

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
    espera();
    // _datosGrafico = getMediciones();
    // _datosGrafico2 = getMediciones2();
    super.initState();
  }

  Future<void> espera() async {
    await TopList();
    await SearchIni();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Tabla(),
        BotonSeleFecha(),
        SizedBox(
          height: 10,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: 'Fecha seleccionada: ', style: TextStyle(fontSize: 15)),
              TextSpan(
                  text: '${DateFormat('dd-MM-yyyy').format(fechaValue)}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
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
        title: ChartTitle(text: "Mediciones (mg/dl)"),
        primaryXAxis: CategoryAxis(),
        //legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<MedicionModel, String>(
            name: "Historial Mediciones",
            dataSource: listMedicionModelGrafico,
            xValueMapper: (MedicionModel med, _) => med.count.toString(),
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
          initialDate: fechaValue,
          firstDate: DateTime(2018),
          lastDate: DateTime.now(),
        ).then((DateTime? value) async {
          if (value != null) {
            fechaValue = value;
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
                      ))
                  .toList();
            });
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
      //return LoginModel.fromJson(jsonDecode(response.body));
      return response.body;
    } else {
      responseStatus = response.statusCode;
      throw Exception('Failed to search date.');
    }
  }

  Future<void> SearchIni() async {
    final String CadenaConexion = 'http://localhost:8080/measure/search';
    int idN = AppProvider().userModel.id!;
    var json = {'userId': idN, 'date': '2022-02-01'};
    final response = await http.post(Uri.parse(CadenaConexion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(json));

    if (response.statusCode == 200) {
      String fechita = fechaValue.toString();
      print(' esto es una fecha $fechita');
      responseStatus = response.statusCode;
      //return LoginModel.fromJson(jsonDecode(response.body));
      List jsonMed = jsonDecode(response.body);
      print('Lista de mediciones $jsonMed');
      listMedicionModel = jsonMed
          .map((medida) => MedicionModel(
                id: medida['id'],
                medida: medida['measurement'],
                dia: medida['measure_date'],
              ))
          .toList();
      setState(() {});
      print(listMedicionModel);
    } else {
      responseStatus = response.statusCode;
      throw Exception('Failed to search date.');
    }
  }

  Future<void> TopList() async {
    final String CadenaConexion = 'http://localhost:8080/measure/list';
    int idN = AppProvider().userModel.id!;
    var json = {'userId': idN, 'count': 10};
    final response = await http.post(Uri.parse(CadenaConexion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(json));

    if (response.statusCode == 200) {
      int i = 0;
      responseStatus = response.statusCode;
      List jsonGrafico = jsonDecode(response.body);
      print('Lista de mediciones $jsonGrafico');
      listMedicionModelGrafico = jsonGrafico
          .map((medida) => MedicionModel(
              id: medida['id'],
              medida: medida['measurement'],
              dia: medida['measure_date'],
              count: i = i + 1))
          .toList();
      setState(() {});
      print(listMedicionModelGrafico);
      //return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      responseStatus = response.statusCode;
      throw Exception('Failed to search date.');
    }
  }

  Widget TextoFecha(date) {
    return Text('Fecha ${date}');
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



