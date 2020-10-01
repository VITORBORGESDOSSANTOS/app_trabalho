import 'package:app_trabalho/ex_01.dart';
import 'package:app_trabalho/ex_02.dart';
import 'package:app_trabalho/ex_03.dart';
import 'package:app_trabalho/ex_04.dart';
import 'package:app_trabalho/ex_05.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trabalho App Exercicios'),
      ),
      body: Center(
        child: Column(
          children: [
            // RaisedButton(
            //   child: Text('Fatorial'),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Fatorial()),
            //     );
            //   },
            // ),
            // RaisedButton(
            //   child: Text('Calculadora'),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Calculadora()),
            //     );
            //   },
            // ),
            RaisedButton(
              child: Text('Ex_01'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ex_01()),
                );
              },
            ),
            RaisedButton(
              child: Text('Ex_02'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ex_02()),
                );
              },
            ),
            RaisedButton(
              child: Text('Ex_03'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ex_03()),
                );
              },
            ),
            RaisedButton(
              child: Text('Ex_04'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ex_04()),
                );
              },
            ),
            RaisedButton(
              child: Text('Ex_05'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ex_05()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
