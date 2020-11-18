import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double eqautionFontSize = 38;
  double resultFontSize = 48;

  buttonPressed( String buttonText){ 
    setState(() {
      if(buttonText == "C"){ 
        equation = '0';
        result = '0';
        eqautionFontSize = 38;
        resultFontSize = 48;
      }else if(buttonText == "⌫"){
        eqautionFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0,equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }else if(buttonText == "="){
        eqautionFontSize = 38;
        resultFontSize = 48;
        equation = buttonText;

        expression =equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){

        }
      }else{ 
        equation = equation + buttonText;
      }
    });
  }


  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return  Container( 
                          height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
                          color: buttonColor,
                          child: FlatButton( 
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide( 
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid
                              )
                            ),
                            padding: EdgeInsets.all(16),
                            onPressed: () => buttonPressed(buttonText),
                            child:Text( 
                              buttonText,
                              style: TextStyle( 
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                                color: Colors.white
                              ),
                            ) ,
                            
                          ),
                        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Calculator'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column( 
        children: [
          Container( 
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,
            style: TextStyle( fontSize: eqautionFontSize),
            ),
          ),
          Container( 
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result,
            style: TextStyle( fontSize: resultFontSize),
            ),
          ),
          Expanded( 
            child: Divider(),
          ),
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container( 
                width: MediaQuery.of(context).size.width * .75,
                child: Table( 
                  children: [
                    TableRow( 
                      children: [
                        buildButton("C", 1, Colors.red),
                        buildButton("⌫", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),

                      ]
                    ),
                    TableRow( 
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                      ]
                    ),
                    TableRow( 
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                      ]
                    ),
                    TableRow( 
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                      ]
                    ),
                    TableRow( 
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),
                      ]
                    )
                  ],
                ),
              ),
              Container( 
                width: MediaQuery.of(context).size.width *0.25,
                child: Table( 
                  children: [
                    TableRow( 
                      children: [
                        buildButton("×", 1, Colors.blue),
                      ]
                    ),
                    TableRow( 
                      children: [
                        buildButton("-", 1, Colors.blue),
                      ]
                    ),
                    TableRow( 
                      children: [
                        buildButton("+", 1, Colors.blue),
                      ]
                    ),
                    TableRow( 
                      children: [
                        buildButton("=", 2, Colors.red),
                      ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

//⌫ ×