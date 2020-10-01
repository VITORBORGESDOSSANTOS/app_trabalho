import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ex_05 extends StatefulWidget {
  @override
  _Ex_05State createState() => _Ex_05State();
}

class _Ex_05State extends State<Ex_05> {
  TextEditingController _repeticaoController = TextEditingController();
  TextEditingController _hController = TextEditingController();
  TextEditingController _dController = TextEditingController();
  TextEditingController _gController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String simNao = "?";

  static const platform = const MethodChannel("channel");

  //Metodo para ser executado sempre que ouver alteração no widget "Text"
  void resultado() {
    setState(() {
      simNao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercício 05"),
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
                controller: _hController,
                decoration: InputDecoration(
                    labelText: "Altura",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar a Altura";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _dController,
                decoration: InputDecoration(
                    labelText: "Diametro",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar o Diametro";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _gController,
                decoration: InputDecoration(
                    labelText: "galhos",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Favor informar a qtde de galhos";
                  }
                },
              ),
              Text(
                'Resposta: $simNao',
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
                        await _calcSimNao(_hController.text, _dController.text,
                            _gController.text);
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

  Future _calcSimNao(h, d, g) async {
    try {
      final String result = await platform.invokeMethod("_calcSimNao", {
        "h": _hController.text,
        "d": _dController.text,
        "g": _gController.text,
      });
      simNao = result;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _resetFields() {
    _hController.text = "";
    _dController.text = "";
    _gController.text = "";
    _repeticaoController.text = "";
    simNao = "?";
    setState(() {
      _formkey = GlobalKey<FormState>();
    });
  }
}
