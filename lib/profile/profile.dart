import 'package:demo_youtube/bottom_navbar.dart';
import 'package:demo_youtube/login.dart';
import 'package:demo_youtube/models/user_model.dart';
import 'package:flutter/material.dart';

import '../provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          Datos(ini: "eMail: ", dat: "${AppProvider().userModel.email!}"),
          Datos(ini: "Teléfono: ", dat: "${AppProvider().userModel.phone!}"),
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
            child: FittedBox(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2, left: 1, right: 1),
                child: Icon(Icons.person, color: Colors.grey.shade100),
              ),
            )),
            decoration: BoxDecoration(
              shape: BoxShape.circle, color: Color(0xFFF25D4D),
              // image: DecorationImage(
              //   image: AssetImage('assets/img/person.png'),
              //   fit: BoxFit.fitHeight,
              // ),
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
                    "${AppProvider().userModel.name!}",
                    style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: Text(
                    "${AppProvider().userModel.lastName!}",
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
        AppProvider().userModel = UserModel();
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
