import 'dart:convert';

import 'package:demo_youtube/bottom_navbar.dart';
import 'package:demo_youtube/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user_model.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerRepeatPassword = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();

  String futureLoginModel = "";

  int responseStatus = 400;
  String userResponse = "";
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cuerpo(context),
    );
  }

  Future<String> CreateUser(String email, String password, String name,
      String lastName, String phone) async {
    final String CadenaConexion = 'http://MBP-DE-RALF/users';
    var json = {
      "name": name,
      "lastname": lastName,
      "email": email,
      "password": password,
      "phone": phone
    };
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
      throw Exception('Failed to create user.');
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
      child: ListView(
        padding: EdgeInsets.only(top: 20, bottom: 50),
        children: [
          Cabecera(context),
          Nombre(),
          SizedBox(height: 25),
          CampoUsuario("Nombre", _controllerName),
          SizedBox(height: 10),
          CampoUsuario("Apellido", _controllerLastName),
          SizedBox(height: 10),
          CampoMail(),
          SizedBox(height: 10),
          CampoContrasena("Contraseña", _controllerPassword),
          SizedBox(height: 10),
          CampoContrasena("Repetir contraseña", _controllerRepeatPassword),
          SizedBox(height: 10),
          CampoTelefono(),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
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
        "Crear cuenta",
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
        controller: _controllerEmail,
        decoration: InputDecoration(
          hintText: "Mail",
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget CampoUsuario(String text, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget CampoContrasena(String text, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        controller: controller,
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
        controller: _controllerPhone,
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
      onPressed: () async {
        String Email = _controllerEmail.text.toString() != null
            ? _controllerEmail.text.toString()
            : "";
        String Password = _controllerPassword.text.toString() != null
            ? _controllerPassword.text.toString()
            : "";
        String Name = _controllerPassword.text.toString() != null
            ? _controllerName.text.toString()
            : "";
        String LastName = _controllerPassword.text.toString() != null
            ? _controllerLastName.text.toString()
            : "";
        String Phone = _controllerPassword.text.toString() != null
            ? _controllerPhone.text.toString()
            : "";
        if (_controllerPassword.text == _controllerRepeatPassword.text) {
          userResponse =
              await CreateUser(Email, Password, Name, LastName, Phone);
          print(userResponse);
          var jsonUser = jsonDecode(userResponse);
          userModel = UserModel.fromJson(jsonUser);
          if (responseStatus == 200) {
            print("Entro aqui");
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return Login();
              },
            ), (Route<dynamic> route) => false);
          } else {
            print('No se pudo hacer nada esta por explotar');
          }
        } else {
          print(_controllerPassword.text);
          print(_controllerRepeatPassword.text);
          print("las contrseñas no coinciden");
        }
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
}
