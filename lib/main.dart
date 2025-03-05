import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "0";
  String _temp = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;

  void _onPress(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _temp = "";
        _operator = "";
        _num1 = 0;
        _num2 = 0;
      } else if (value == "=") {
        _num2 = double.tryParse(_temp) ?? 0;
        switch (_operator) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "x":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            _output = _num2 != 0 ? (_num1 / _num2).toString() : "Error";
            break;
          case "%":
            _output = (_num1 * (_num2 / 100)).toString();
            break;
        }
        _temp = _output;
        _operator = "";
      } else if (["+", "-", "x", "/", "%"].contains(value)) {
        _num1 = double.tryParse(_temp) ?? 0;
        _operator = value;
        _temp = "";
      } else {
        _temp += value;
        _output = _temp;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPress(value),
        child: Text(value, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculadora")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(_output, style: TextStyle(fontSize: 48)),
            ),
          ),
          Column(
            children: [
              ["7", "8", "9", "/"],
              ["4", "5", "6", "x"],
              ["1", "2", "3", "-"],
              ["C", "0", "=", "+"],
              ["%"]
            ].map((row) {
              return Row(
                children: row.map((value) => _buildButton(value)).toList(),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}