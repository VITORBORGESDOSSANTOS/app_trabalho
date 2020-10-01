import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ex_01 extends StatefulWidget {
  @override
  _Ex_01State createState() => _Ex_01State();
}

class _Ex_01State extends State<Ex_01> {
  TextEditingController _valoraController = TextEditingController();
  TextEditingController _valorbController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // atribui zero ao valor para não ficar feio o "NULL"
  int valor = 0;

  static const platform = const MethodChannel("channel");

  //Metodo para ser executado sempre que ouver alteração no widget "Text"
  void resultado() {
    setState(() {
      valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercício 01"),
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
                controller: _valoraController,
                decoration: InputDecoration(
                    labelText: "Valor A",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar um valor";
                  }
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _valorbController,
                decoration: InputDecoration(
                    labelText: "Valor B",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar um valor";
                  }
                },
              ),
              //Text porque se não ele requer um controle
              Text(
                'Resultado: $valor',
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
                        "Somar",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        // acrescentado um await para ele sempre pegar o valores atualizados
                        await _soma(
                            _valoraController.text, _valorbController.text);
                      }
                      // aqui eu chamo o metodo que tem o setState
                      await resultado();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _soma(valora, valorb) async {
    try {
      final int result = await platform.invokeMethod("_soma",
          {"valora": _valoraController.text, "valorb": _valorbController.text});
      valor = result;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _resetFields() {
    _valoraController.text = "";
    _valorbController.text = "";
    valor = 0;
    setState(() {
      _formkey = GlobalKey<FormState>();
    });
  }
}
