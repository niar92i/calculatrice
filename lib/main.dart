import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculatrice",
      theme: ThemeData(primarySwatch: Colors.red),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String previousResult = "0";
  String expression = "0";
  String nextEquation = "0";

  buttonPressed(String textButton) {
    setState(() {
      switch(textButton) {
        case "C":
          equation = "0";
          result = "0";
          previousResult = "0";
          expression = "0";
          nextEquation = "0";
          break;
        case "⌫":
          // if (previousResult != "0"){
          //   nextEquation = previousResult;
          //   previousResult = previousResult.substring(0, nextEquation.length - 1);
          //   if (equation.isEmpty){
          //     equation = "0";
          //   }
          // } else {
        print("alohan'ny hamafa");
            print(equation);
            print("equation tonga rehefa avy mamafa");
        equation = equation.substring(0, equation.length - 1);
        previousResult = previousResult.substring(0, nextEquation.length - 1);
            print(equation);
            if (equation.isEmpty){
              equation = "0";
            }
          // }
          break;
        case "=":
          if (previousResult != "0"){
            equation = previousResult;
          }
          expression = equation;
          try{
            Parser parser = Parser();
            Expression exp = parser.parse(expression);
            ContextModel cm = ContextModel();
            double realResult = exp.evaluate(EvaluationType.REAL, cm);
            if (realResult % 1 == 0) {
              result = realResult.toInt().toString(); //Avoir un resultat sans la décimale si cette dernière est égale à zero, convertir le resultat obtenu en String
            } else {
              result = realResult.toStringAsFixed(10); //Limite le nombre de décimales du resultat à 10
              result = result.replaceAll(RegExp(r'0*$'), ''); //Supprime les zéros inutiles après la virgule
              result = result.replaceAll(RegExp(r'\.$'), ''); //Supprime le point virgule s'il est suivi de zéros
            }
            previousResult = result;
            nextEquation = equation;
            equation = "$equation=$previousResult";
            print("resultat farany previous");
            print(previousResult);
          }catch(e){
            result = "Syntax error";
            print(e);
          }
          break;
        default:
          if (equation == "0") {
            equation = textButton;
          }
          else if (previousResult != "0"){
            previousResult = previousResult + textButton;
            print("valeur previousresult");
            print(previousResult);
            equation = previousResult;
            // equation = previousResult;
            print("napiko zavatra nptq");
            print(equation);
          }
          else{
            equation = equation + textButton;
            print("tafiditra ato ve");
          }
      }
    });
  }

  Widget calculatorButton(String textButton, Color colorText, Color colorButton){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(16),
      color: colorButton,
      child: MaterialButton(onPressed: ()=>buttonPressed(textButton), child: Text(textButton, style: TextStyle(color: colorText, fontSize: 30, fontWeight: FontWeight.normal),),),
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
            child: Text(equation, style: const TextStyle(fontSize: 25),),
          ),
          Container( //Contient le résultat obtenu après avoir validé l'équation
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(result, style: const TextStyle(fontSize: 50),),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container( //Contient le pad de la calculatrice
                width: MediaQuery.of(context).size.width,
                child: Table(
                children: [
                  TableRow(
                    children: [
                      calculatorButton("C", Colors.red, Colors.white), //Tout initialiser
                      calculatorButton("⌫", Colors.red, Colors.white), //Effacer le dernier input
                      calculatorButton("%", Colors.red, Colors.white), //Modulo
                      calculatorButton("/", Colors.red, Colors.white), //Division
                    ],
                  ),TableRow(
                    children: [
                      calculatorButton("7", Colors.black, Colors.white),
                      calculatorButton("8", Colors.black, Colors.white),
                      calculatorButton("9", Colors.black, Colors.white),
                      calculatorButton("*", Colors.red, Colors.white),
                    ],
                  ),TableRow(
                    children: [
                      calculatorButton("4", Colors.black, Colors.white),
                      calculatorButton("5", Colors.black, Colors.white),
                      calculatorButton("6", Colors.black, Colors.white),
                      calculatorButton("-", Colors.red, Colors.white), //Soustraction
                    ],
                  ),TableRow(
                    children: [
                      calculatorButton("1", Colors.black, Colors.white),
                      calculatorButton("2", Colors.black, Colors.white),
                      calculatorButton("3", Colors.black, Colors.white),
                      calculatorButton("+", Colors.red, Colors.white), //Addition
                    ],
                  ),TableRow(
                    children: [
                      calculatorButton(".", Colors.black, Colors.white),
                      calculatorButton("0", Colors.black, Colors.white),
                      calculatorButton("00", Colors.black, Colors.white),
                      calculatorButton("=", Colors.red, Colors.white), //Afficher le résultat
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
