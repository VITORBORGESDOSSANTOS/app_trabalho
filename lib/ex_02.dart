import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ex_02 extends StatefulWidget {
  @override
  _Ex_02State createState() => _Ex_02State();
}

class _Ex_02State extends State<Ex_02> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _vendaController = TextEditingController();
  TextEditingController _salarioController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  double total = 0.0;

  static const platform = const MethodChannel("channel");

  //Metodo para ser executado sempre que ouver alteração no widget "Text"
  void resultado() {
    setState(() {
      total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercício 02"),
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
                keyboardType: TextInputType.text,
                controller: _nomeController,
                decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar um Nome";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _vendaController,
                decoration: InputDecoration(
                    labelText: "Venda",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar o valor vendido";
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _salarioController,
                decoration: InputDecoration(
                    labelText: "Salario",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar o salario";
                  }
                },
              ),

              //  Text porque se não ele requer um controle
              Text(
                'Resultado: $total',
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
                        "Calcular Salario",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        // acrescentado um await para ele sempre pegar o valores atualizados
                        await _calcSalario(
                            _vendaController.text, _salarioController.text);
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

  Future _calcSalario(venda, salario) async {
    try {
      final double result = await platform.invokeMethod("_calcSalario",
          {"venda": _vendaController.text, "salario": _salarioController.text});
      total = result;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _resetFields() {
    _nomeController.text = "";
    _vendaController.text = "";
    _salarioController.text = "";
    total = 0.0;
    setState(() {
      _formkey = GlobalKey<FormState>();
    });
  }
}
