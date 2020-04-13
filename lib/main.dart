import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const String request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=5d207b77";

void main() async {
  runApp(
    MaterialApp(
      title: "Conversor de moedas",
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.monetization_on,
                color: Colors.amber,
                size: 120,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: buildTextField("BRL", "R\$"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: buildTextField("USD", "U\$"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: buildTextField("EUR", "€"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map> getData() async {
    http.Response resposta = await http.get(request);
    return json.decode(resposta.body);
  }

  Widget buildTextField(String label, String prefixo) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white, fontSize: 15, letterSpacing: 2),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            )),
        prefixText: prefixo,
        prefixStyle: TextStyle(
          color: Color.fromRGBO(250, 250, 250, 0.7),
          fontSize: 15,
        ),
        hintText: "0.00",
        hintStyle: TextStyle(
          color: Color.fromRGBO(250, 250, 250, 0.4),
          fontSize: 15,
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
