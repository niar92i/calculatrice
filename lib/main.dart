import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculatrice());
}

class Calculatrice extends StatelessWidget {
  const Calculatrice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculatrice",
      theme: ThemeData(primarySwatch: Colors.red),
      home: CalculatriceSimple(),
    );
  }
}

class CalculatriceSimple extends StatefulWidget {
  const CalculatriceSimple({super.key});

  @override
  State<CalculatriceSimple> createState() => _CalculatriceSimpleState();
}

class _CalculatriceSimpleState extends State<CalculatriceSimple> {

  String equation = "0";
  String result = "0";
  String expression = "0";

  ButtonPressed(String textButton) {
    // print(textButton);
    setState(() {
      if(textButton == "C"){
        equation = "0";
        result = "0";
      } else if (textButton == "⌫"){
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty){
          equation = "0";
        }
      } else if (textButton == "="){ //Expression mathématique pour faire les calculs
          expression = equation;
          try{
            Parser parser = Parser();
            Expression exp = parser.parse(expression);
            ContextModel cm = ContextModel();
            result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          }catch(e){
            result = "Syntax error";
            print(e);
          }
      } else{
        if (equation == "0"){
          equation = textButton;
        }else{
          equation = equation + textButton;
        }
      }
    });
  }

  Widget calculatriceButton(String textButton, Color colorText, Color colorButton){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.all(16),
      color: colorButton,
      child: MaterialButton(onPressed: ()=>ButtonPressed(textButton), child: Text(textButton, style: TextStyle(color: colorText, fontSize: 30, fontWeight: FontWeight.normal),),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculatrice'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container( //Contient l'équation saisie par l'utilisateur
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: 35),),
          ),
          Container( //Contient les chiffres saisis par l'utilisateur ainsi que le résultat obtenu après avoir validé l'équation
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(result, style: TextStyle(fontSize: 35),),
          ),
          const Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container( //Contient le pad de la calculatrice
                width: MediaQuery.of(context).size.width,
                child: Table(
                children: [
                  TableRow(
                    children: [
                      calculatriceButton("C", Colors.red, Colors.white),
                      calculatriceButton("⌫", Colors.red, Colors.white),
                      calculatriceButton("%", Colors.red, Colors.white),
                      calculatriceButton("/", Colors.red, Colors.white),
                    ],
                  ),TableRow(
                    children: [
                      calculatriceButton("7", Colors.black, Colors.white),
                      calculatriceButton("8", Colors.black, Colors.white),
                      calculatriceButton("9", Colors.black, Colors.white),
                      calculatriceButton("*", Colors.red, Colors.white),
                    ],
                  ),TableRow(
                    children: [
                      calculatriceButton("4", Colors.black, Colors.white),
                      calculatriceButton("5", Colors.black, Colors.white),
                      calculatriceButton("6", Colors.black, Colors.white),
                      calculatriceButton("-", Colors.red, Colors.white),
                    ],
                  ),TableRow(
                    children: [
                      calculatriceButton("1", Colors.black, Colors.white),
                      calculatriceButton("2", Colors.black, Colors.white),
                      calculatriceButton("3", Colors.black, Colors.white),
                      calculatriceButton("+", Colors.red, Colors.white),
                    ],
                  ),TableRow(
                    children: [
                      calculatriceButton(".", Colors.black, Colors.white),
                      calculatriceButton("0", Colors.black, Colors.white),
                      calculatriceButton("00", Colors.black, Colors.white),
                      calculatriceButton("=", Colors.red, Colors.white),
                    ],
                  ),
                ],
              ),)
            ],
          ),
        ],
      ),
    );
  }
}
