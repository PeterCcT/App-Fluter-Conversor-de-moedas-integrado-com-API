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
  double euro;
  double dolar;
  final dolController = TextEditingController();
  final eurController = TextEditingController();
  final realController = TextEditingController();

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clear();
    }
    double real = double.parse(text);
    dolController.text = (real / dolar).toStringAsFixed(2);
    eurController.text = (real / euro).toStringAsFixed(2);
  }

  void _eurChanged(String text) {
    if (text.isEmpty) {
      _clear();
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    eurController.text = ((euro * this.euro) / dolar).toStringAsFixed(2);
  }

  void _dolChanged(String text) {
    if (text.isEmpty) {
      _clear();
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    eurController.text = ((dolar * this.dolar) / euro).toStringAsFixed(2);
  }

  void _clear() {
    realController.text = "";
    dolController.text = "";
    eurController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando dados",
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                    textAlign: TextAlign.center),
              );

              break;
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar dados",
                      style: TextStyle(color: Colors.amber, fontSize: 20),
                      textAlign: TextAlign.center),
                );
              } else {
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                return SingleChildScrollView(
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
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: buildTextField(
                              "BRL", "R\$", realController, _realChanged),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: buildTextField(
                              "USD", "U\$", dolController, _dolChanged),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: buildTextField(
                              "EUR", "€", eurController, _eurChanged),
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Future<Map> getData() async {
    http.Response resposta = await http.get(request);
    return json.decode(resposta.body);
  }

  Widget buildTextField(String label, String prefixo,
      TextEditingController control, Function converter) {
    return TextFormField(
      controller: control,
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
      onChanged: converter,
    );
  }
}
