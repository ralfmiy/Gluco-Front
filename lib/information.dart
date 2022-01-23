import 'package:demo_youtube/BottomNav.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/img/grisnew.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      children: [
        Cabecera(context),
        Nombre(),
        SizedBox(height: 25),
        Informacion(context),
        SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: BotonAceptar(context),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget Cabecera(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.3,
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Image.asset(
            'assets/img/gluconewnew.png',
            fit: BoxFit.contain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 25, top: 50),
          alignment: Alignment.centerRight,
          child: Text(
            "Gluco",
            style: TextStyle(
                color: Colors.red[800],
                fontSize: 50,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

Widget Nombre() {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 20),
    child: Text(
      "Información",
      style: TextStyle(
        color: Colors.black,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget BotonAceptar(BuildContext context) {
  return FlatButton(
    onPressed: () {
      Navigator.pop(context);
    },
    minWidth: 150,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      // side: BorderSide(
      //   color: Colors.black,
      //   width: 0.5,
      // ),
    ),
    child: Text(
      "Aceptar",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.blue[400],
  );
}

Widget Informacion(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    padding: EdgeInsets.all(30),
    height: MediaQuery.of(context).size.height * 0.4,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), color: Colors.white),
    child: ListView(padding: EdgeInsets.zero, children: [
      Text(
        "Esta aplicación fue desarrollada únicamente para fines académicos.\nEste prototipo de aplicación es parte de la demostración del medidor de glucosa en sangre no invasivo.\nAl ser un prototipo entiendase que las mediciones de azúcar en sangre pueden no ser exactas o no ser correctas.\nDesarrolladores: Nicolás Mendoza y Ralf Miy.\nProyecto de grado de la carrera de Ingeniería Informática\nUniversidad Católica de Salta\nAño: 2022",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        textAlign: TextAlign.justify,
      ),
    ]),
  );
}
