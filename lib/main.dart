import 'package:flutter/material.dart';

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

  Widget calculatriceButton(String textButton, Color colorText, Color colorButton){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.all(16),
      color: colorButton,
      child: MaterialButton(onPressed: null, child: Text(textButton, style: TextStyle(color: colorText, fontSize: 30, fontWeight: FontWeight.normal),),),
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
          Container( //Conteneur qui contient l'équation
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text('0', style: TextStyle(fontSize: 35),),
          ),
          Container( //Conteneur qui contient les chiffres saisis par l'utilisateur
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text('0', style: TextStyle(fontSize: 35),),
          ),
          const Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                children: [
                  TableRow(
                    children: [
                      calculatriceButton("C", Colors.red, Colors.white),
                      MaterialButton(onPressed: null, child: Text('⌫', style: TextStyle(color: Colors.red),),),
                      MaterialButton(onPressed: null, child: Text('%', style: TextStyle(color: Colors.red),),),
                      MaterialButton(onPressed: null, child: Text('+', style: TextStyle(color: Colors.red),),)
                    ],
                  )
                ],
              ),)
            ],
          ),
        ],
      ),
    );
  }
}
