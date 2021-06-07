import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

//standless e estático
//statefull e renderizado quando e feito uma ação
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinacontroller = TextEditingController();
  String _resultado = "Informe os valores";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _reset() {
    alcoolController.text = "";
    gasolinacontroller.text = "";
    setState(() {
      _resultado = "Informe os valores";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculaCombustivelIdeal() {
    //setState funciona so com statefullWidget ele vai atualizar constantemente a tela
    setState(() {
      double vAlcool = double.parse(alcoolController.text.replaceAll(",", '.'));
      double vGasolina =
          double.parse(gasolinacontroller.text.replaceAll(",", "."));
      double proporcao = vAlcool / vGasolina;

      if (proporcao < 0.7) {
        _resultado = "Abastaça com Alcool";
      } else {
        _resultado = "Abastaça com Gasolina";
      }
    });
    //if ternario
    //_resultado = (proporca0 <0.7) ? "Abasteça com Alcool" : "Abasteça com Gasolina";
  }

  @override
  Widget build(BuildContext context) {
    //Scalffold e navegão do topo do aplicativo
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Álcool ou Gasolina ?",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[900],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _reset();
                })
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.local_gas_station,
                    size: 140.0,
                    color: Colors.lightBlue[900],
                  ),
                  TextFormField(
                    controller: alcoolController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                    value.isEmpty ? "Informe o valor do Gasolina" : null,
                    decoration: InputDecoration(
                        labelText: "valor do ÁLcool",
                        labelStyle: TextStyle(color: Colors.lightBlue[900])),
                    style: TextStyle(
                      color: Colors.lightBlue[900],
                      fontSize: 26.0,
                    ),
                  ),
                  TextFormField(
                    controller: gasolinacontroller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isEmpty ? "Informe o valor do Alcool" : null,
                    decoration: InputDecoration(
                        labelText: "valor da Gasolina",
                        labelStyle: TextStyle(color: Colors.lightBlue[900])),
                    style: TextStyle(
                      color: Colors.lightBlue[900],
                      fontSize: 26.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formkey.currentState.validate())
                          _calculaCombustivelIdeal();
                        },
                        child: Text(
                          "verificar",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.lightBlue[900],
                      ),
                    ),
                  ),
                  Text(_resultado,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue[900],
                        fontSize: 26.0,
                      ))
                ],
              ),
            )));
  }
}
