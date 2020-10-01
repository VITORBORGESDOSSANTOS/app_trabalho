import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ex_03 extends StatefulWidget {
  @override
  _Ex_03State createState() => _Ex_03State();
}

class _Ex_03State extends State<Ex_03> {
  TextEditingController _notaController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List notas = [];

  static const platform = const MethodChannel("channel");

  //Metodo para ser executado sempre que ouver alteração no widget "Text"
  void resultado() {
    setState(() {
      notas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercício 03"),
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
                    labelText: "Valor Nota",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar o Valor da Nota";
                  }
                },
              ),
              // Text porque se não ele requer um controle
              Text(
                '$notas'
                //'$notas'[1] + ' nota(s) de 100,00\n'
                // + '$notas'[4] +
                // ' notas(s) de 50,00\n' +
                // '$notas'[7] +
                // ' notas(s) de 20,00\n' +
                // '$notas'[10] +
                // ' notas(s) de 10,00\n' +
                // '$notas'[13] +
                // ' notas(s) de 5,00\n' +
                // '$notas'[16] +
                // ' notas(s) de 1,00\n'
                ,
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
                        "Listar Notas",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        // acrescentado um await para ele sempre pegar o valores atualizados
                        await _calcNotas(_notaController.text);
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

  Future _calcNotas(nota) async {
    try {
      final List result = await platform
          .invokeMethod("_calcNotas", {"nota": _notaController.text});
      notas = result;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _resetFields() {
    _notaController.text = "";
    setState(() {
      _formkey = GlobalKey<FormState>();
    });
  }
}
