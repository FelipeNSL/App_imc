import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget buildTextField(String label, TextEditingController c) {
    return TextField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.green, fontSize: 20.0),
          border: OutlineInputBorder()),
      style: TextStyle(color: Colors.green, fontSize: 20.0),
      keyboardType: TextInputType.number,
      controller: c,
    );
  }

  void _resetFilter() {
    setState(() {
      pesoContoller.text = "";
      altContoller.text = "";
      inforText = "Informe seus dados";
    });
  }

  String inforText = "Informe seus dados";

  TextEditingController pesoContoller = TextEditingController();
  TextEditingController altContoller = TextEditingController();

  void _changeImc() {
    double peso = double.parse(pesoContoller.text); //peso
    double altura = double.parse(altContoller.text) / 100; //altura
    double imc = peso / (altura * altura);

    setState(() {
      if (imc < 17) {
        inforText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.5 && imc <= 24.9) {
        inforText = "Peso normal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 25 && imc <= 29.9) {
        inforText = "Acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc <= 34.9) {
        inforText = "Obesidade 1 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 35 && imc <= 39.9) {
        inforText = "Obesidade 2 (${imc.toStringAsPrecision(4)})";
      } else if (imc > 40) {
        inforText = "Obesidade Mórbita (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Calculador de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFilter();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.person_outlined, size: 170.0, color: Colors.green),
            buildTextField("Peso", pesoContoller),
            Divider(),
            buildTextField("Altura", altContoller),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 50,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    "Verificar",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  onPressed: () {
                    _changeImc();
                  },
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                inforText,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
