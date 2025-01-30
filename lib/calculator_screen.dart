import 'package:calc/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    //use screen size for responsive
    final screenSize = MediaQuery.of(context).size;

    return  Scaffold(
      body:SafeArea( // Safe Area prevents app from overlapping with top and bottom android ui
        bottom: true, //sets the safearea at the bottom to false
        child: 
          Column(
            children:[ Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  child : Text("0",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                  )
                ),
              ),
            ),
            Wrap(
              children: Btn.buttonValues.map((value) => SizedBox(
              width: screenSize.width / 4,
              height: screenSize.width / 5,
              child: buildButton(value),
              
              )).toList(),
            )
          ])

      )
    );
  }

  Widget buildButton(value){
    return Text(value);
  }
}