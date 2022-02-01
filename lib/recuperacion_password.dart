import 'package:demo_youtube/bottom_navbar.dart';
import 'package:demo_youtube/create_user.dart';
import 'package:flutter/material.dart';

class RecuperacionPassword extends StatefulWidget {
  @override
  _RecuperacionPasswordState createState() => _RecuperacionPasswordState();
}

class _RecuperacionPasswordState extends State<RecuperacionPassword> {
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
        // image: NetworkImage(
        //     "https://png.pngtree.com/thumb_back/fw800/background/20190223/ourmid/pngtree-beautiful-forest-night-purple-background-material-nightnight-viewnightat-nightnightmoonsimplewooddead-image_79316.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25),
          Cabecera(context),
          Nombre(),
          SizedBox(height: 25),
          CampoMail(),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _BotonCancelar(context),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: BotonEnviar(context),
                ),
              ],
            ),
          ),
        ],
      ),
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
      "Recuperación contraseña",
      style: TextStyle(
        color: Colors.black,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget CampoMail() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Mail",
        fillColor: Colors.white,
        filled: true,
      ),
    ),
  );
}

Widget BotonEnviar(BuildContext context) {
  return FlatButton(
    onPressed: () {
      Navigator.pop(context);
    },
    minWidth: 150,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(
        color: Colors.black,
        width: 0.5,
      ),
    ),
    child: Text(
      "Enviar",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.blue[400],
  );
}

Widget _BotonCancelar(BuildContext context) {
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
      "Cancelar",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.red[800],
  );
}

