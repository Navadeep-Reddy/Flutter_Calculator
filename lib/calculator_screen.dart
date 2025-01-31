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
    if (value == Btn.del){
      delete();
    }
    if (value == Btn.clr){
      clear();
    }
    if (value == Btn.per){
      convertToPercentage();
    }
    if (value == Btn.calculate){
      calculate();
    }

    appendValue(value);
}

  void calculate(){
    if (number1.isEmpty || number2.isEmpty || operand.isEmpty) return;

    var num1 = double.parse(number1);
    var num2 = double.parse(number2);
    double result = 0.0;

    switch(operand){
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
        result = 0;
    }
    number1 = "$result";
    if (number1.endsWith(".0")){
      number1 = number1.substring(0, number1.length - 2);
    }
    setState(() {
      number1;
      operand = "";
      number2 = "";
    });
  }

  void convertToPercentage(){
    if (number1.isNotEmpty && number2.isNotEmpty && operand.isNotEmpty){
      //calculate function call 

      //convert 
    }

    if (operand.isNotEmpty){
      //cannot be converted
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${number / 100}";
      number2 = "";
      operand = "";
    });
  }



  void delete(){
    if (number2.isNotEmpty){
      number2 = number2.substring(0, number2.length - 1);
    }
    else if (operand.isNotEmpty){
      operand = "";
    }
    else{
      number1 = number1.substring(0, number1.length - 1);
    }
  }

  void clear(){
    number1 = "";
    number2 = "";
    operand = "";
  }

  void appendValue(String value){
    // checking if something other than . or not any of the numbers
    if (value!= Btn.dot && int.tryParse(value) == null){
      
      if (operand.isNotEmpty && number2.isNotEmpty){
        // later for when we have data
      }
      if (value != Btn.del && value != Btn.clr && value != Btn.per && value != Btn.calculate) operand = value;

    }else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return; //do nothing if number1 already has a dot
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)){
        value = '0.';
      }
      number1 += value;
    }else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return; //do nothing if number1 already has a dot
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)){
        value = '0.';
      }
      number2 += value;

    }
    setState(() {});
  }
}

Color getColor(value){
  return [Btn.del, Btn.clr].contains(value)? Colors.blueGrey: [Btn.per, Btn.multiply, Btn.add, Btn.subtract, Btn.divide, Btn.calculate].contains(value)? Colors.deepOrange: Colors.black;
}


