import 'package:calc/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = "";
  String number2 = "";
  String operand = "";

  @override
  Widget build(BuildContext context) {
    //use screen size for responsive
    final screenSize = MediaQuery.of(context).size;

    return  Scaffold(
      body:SafeArea( // Safe Area prevents app from overlapping with top and bottom android ui
        bottom: true, //sets the safearea at the bottom to false
        child: 
          Column(
            children:[ 
              Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child : Text(
                      "$number1$operand$number2".isEmpty? "0" : "$number1$operand$number2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    )
                  ),
                ),
              ),
            ),
            Wrap(
              children: Btn.buttonValues.map((value) => SizedBox(
              width: value == Btn.calculate? screenSize.width / 2 : screenSize.width / 4,
              height: screenSize.width / 5,
              child: buildButton(value),
              
              )).toList(),
            )
          ])

      )
    );
  }

  Widget buildButton(value){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24
          ),
          borderRadius: BorderRadius.circular(100)),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(child: Text(
            value,
            style: const TextStyle(fontSize: 20),

          ))),
      ),
    );
  }
  void onBtnTap(String value) {
    setState(() {   // Remove the = sign
      number1 += value;
    });
  }
}

Color getColor(value){
  return [Btn.del, Btn.clr].contains(value)? Colors.blueGrey: [Btn.per, Btn.multiply, Btn.add, Btn.subtract, Btn.divide, Btn.calculate].contains(value)? Colors.deepOrange: Colors.black;
}


