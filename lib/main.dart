import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tried = '';
  String _try = '';
  String guess = 'Guess';

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("You guessed right"),
              actions: <Widget>[
                MaterialButton(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      guess = 'Reset';
                      x = Random().nextInt(99) + 1;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  child: const Text('Try again'),
                  onPressed: () {
                    setState(() {
                      tried = '';
                      _try = '';
                      x = Random().nextInt(99) + 1;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  final TextEditingController controller = TextEditingController();

  int x = Random().nextInt(99) + 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Guess my number'),
        ),
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              'I\'m thinking of a number between 1 and 100',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'It\'s your turn to guess my number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          //You tried
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              tried,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 45,
              ),
            ),
          ),

          //Try lower/higher
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              _try,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 45,
              ),
            ),
          ),
              Card(
                child: Column(
                  children: [
                    const Text(
                      'Try a number',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.cyan,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.all(25.0),
                      child: TextField(
                        controller: controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        //padding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ],
                ),
              //),
              ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            child: Text(guess),
            onPressed: () {
              if (guess == 'Reset') {
                setState(() {
                  guess = 'Guess';
                  _try = '';
                  tried = '';
                });
              } else if (guess == 'Guess') {
                final String value = controller.text;
                final double? doubleValue = double.tryParse(value);
                int flag = 0;
                if (doubleValue != null) {
                  if (doubleValue > x) {
                    flag = 1;
                  } else if (doubleValue < x) {
                    flag = 2;
                  } else {
                    flag = 3;
                  }
                }
                else{
                  setState(() {
                    tried = '';
                    _try = '';
                  });
                }
                setState(() {
                  String str_1 = 'You tried ';
                  String strX = controller.text;
                  tried = str_1 + strX;
                  String str = 'Try ';
                  if (flag == 1) {
                    String rez = 'lower';
                    _try = str + rez;
                  } else if (flag == 2) {
                    String rez = 'higher';
                    _try = str + rez;
                  } else if (flag == 3) {
                    //dialogue
                    _try = 'You guessed right';
                    createAlertDialog(context);
                  }
                });
                controller.clear();
              }
            },
          )
        ],
      ),
    );
  }
}
