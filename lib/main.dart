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
      backgroundColor: Colors.indigo[500],
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(18, 21, 76, 1),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.monetization_on,
                color: Color.fromRGBO(50, 150, 212, 1),
                size: 120,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                    prefixText: "RS",
                    prefixStyle: TextStyle(
                      color: Color.fromRGBO(250, 250, 250, 0.7),
                      fontSize: 15,
                    ),
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(250, 250, 250, 0.4),
                      fontSize: 15,
                    ),
                    labelText: "BRL",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                    prefixText: "US",
                    prefixStyle: TextStyle(
                      color: Color.fromRGBO(250, 250, 250, 0.7),
                      fontSize: 15,
                    ),
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(250, 250, 250, 0.4),
                      fontSize: 15,
                    ),
                    labelText: "USD",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixText: "€",
                    prefixStyle: TextStyle(
                      color: Color.fromRGBO(250, 250, 250, 0.7),
                      fontSize: 15,
                    ),
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(250, 250, 250, 0.4),
                      fontSize: 15,
                    ),
                    labelText: "EUR",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
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
}
