import 'package:demo_youtube/BottomNav.dart';
import 'package:demo_youtube/create_user.dart';
import 'package:demo_youtube/recuperacion_password.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          CampoContrasena(),
          SizedBox(height: 25),
          BotonEntrar(context),
          SizedBox(height: 10),
          BotonCrearCuenta(context),
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
      "Bienvenido",
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

Widget CampoContrasena() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Contraseña",
        fillColor: Colors.white,
        filled: true,
      ),
    ),
  );
}

Widget BotonEntrar(BuildContext context) {
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
      side: BorderSide(
        color: Colors.black,
        width: 0.5,
      ),
    ),
    child: Text(
      "Entrar",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.blue[400],
  );
}

Widget BotonCrearCuenta(BuildContext context) {
  return Expanded(
    child: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateUser()),
                  );
                },
                height: 40,
                child: Text(
                  "Crear cuenta",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent[700],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecuperacionPassword()),
                  );
                },
                height: 40,
                child: Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent[700],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          right: 0,
          child: FlatButton.icon(
            onPressed: () {},
            height: 40,
            label: Text(
              "",
            ),
            icon: Icon(
              Icons.info,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
