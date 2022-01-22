import 'package:demo_youtube/BottomNav.dart';
import 'package:demo_youtube/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: Column(
        children: [
          SizedBox(height: 25),
          Cabecera(context),
          Nombre(),
          Separador(context),
          Datos(ini: "eMail: ", dat: "ralfmiy@hotmail.com"),
          Datos(ini: "Teléfono: ", dat: "387-5353233"),
          //eMail(ini: "Fecha Nacimiento: ", dat: "14/11/1996"),
          Expanded(
            child: Container(),
          ),
          // BotonCambiarFoto(context),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          BotonCerrarSesion(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05)
        ],
      ),
    );
  }

  Widget Cabecera(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30),
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/img/fondo.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Ralf",
                    style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: Text(
                    "Miy",
                    style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Nombre() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30),
      child: Text(
        "Perfil",
        style: TextStyle(
          color: Colors.black,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Datos({String ini = "", String dat = ""}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30, top: 25),
      child: Row(
        children: [
          Text(
            ini,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            dat,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget BotonCerrarSesion(context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return Login();
          },
        ), (Route<dynamic> route) => false);
      },
      minWidth: MediaQuery.of(context).size.width * 0.65,
      height: 55,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        // side: BorderSide(
        //   color: Colors.black,
        //   width: 0.0,
        // ),
      ),
      child: Text(
        "Cerrar Sesión",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      color: Colors.red[800],
    );
  }

  Widget BotonCambiarFoto(context) {
    return FlatButton(
      onPressed: () {},
      minWidth: MediaQuery.of(context).size.width * 0.65,
      height: 55,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        // side: BorderSide(
        //   color: Colors.black,
        //   width: 0.0,
        // ),
      ),
      child: Text(
        "Cambiar Foto",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Colors.green[400],
    );
  }

  Widget Separador(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: Colors.grey[700],
      height: 2,
      width: MediaQuery.of(context).size.width,
    );
  }
}
