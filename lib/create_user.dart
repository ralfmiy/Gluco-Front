import 'package:demo_youtube/BottomNav.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
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
          CampoUsuario(),
          SizedBox(height: 10),
          CampoContrasena("Contraseña"),
          SizedBox(height: 10),
          CampoContrasena("Repetir contraseña"),
          SizedBox(height: 10),
          CampoTelefono(),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: BotonCancelar(context),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: BotonCrearCuenta(context),
                ),
              ],
            ),
          )
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
      "Crear cuenta",
      style: TextStyle(
        color: Colors.black,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget CampoUsuario() {
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

Widget CampoContrasena(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: text,
        fillColor: Colors.white,
        filled: true,
      ),
    ),
  );
}

Widget CampoTelefono() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Teléfono",
        fillColor: Colors.white,
        filled: true,
      ),
    ),
  );
}

Widget BotonCrearCuenta(BuildContext context) {
  return FlatButton(
    onPressed: () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return NavBar();
        },
      ), (Route<dynamic> route) => false);
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
      "Crear",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.blue[400],
  );
}

Widget BotonCancelar(BuildContext context) {
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
