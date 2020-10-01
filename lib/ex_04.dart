import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ex_04 extends StatefulWidget {
  @override
  _Ex_04State createState() => _Ex_04State();
}

class _Ex_04State extends State<Ex_04> {
  TextEditingController _notaController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String conceito = "?";

  static const platform = const MethodChannel("channel");

  //Metodo para ser executado sempre que ouver alteração no widget "Text"
  void resultado() {
    setState(() {
      conceito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercício 04"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _notaController,
                decoration: InputDecoration(
                    labelText: "Nota",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar a Nota";
                  }
                },
              ),
              Text(
                'Conceito: $conceito',
                style: TextStyle(fontSize: 25.0, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 70,
                child: RaisedButton(
                    child: Center(
                      child: Text(
                        "Resultado",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        // acrescentado um await para ele sempre pegar o valores atualizados
                        await _calcConceito(_notaController.text);
                      }
                      // chamando o metodo que tem o setState
                      await resultado();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _calcConceito(nota) async {
    try {
      final String result = await platform
          .invokeMethod("_calcConceito", {"nota": _notaController.text});
      conceito = result;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _resetFields() {
    _notaController.text = "";
    conceito = "?";
    setState(() {
      _formkey = GlobalKey<FormState>();
    });
  }
}
