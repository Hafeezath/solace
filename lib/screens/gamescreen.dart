import 'package:flutter/material.dart';
import 'package:solace/screens/screens.dart';
import 'numbergame.dart';
import 'package:solace/screens/tictactoe.dart';

void main() {
  runApp(const MyApp());
  debugShowCheckedModeBanner:
  false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const String id = 'gamescreen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage('assets/images/gaming.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'We fail, We break, We fall. But then we rise, we heal, we overcome. Select your game to heal yourself',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.blue, // background
                textColor: Colors.white, // foreground
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicTacToe(),
                    ),
                  );
                },
                child: Text(
                  'Tic Tac Toe',
                ),
              ),
              SizedBox(height: 8.0),
              RaisedButton(
                color: Colors.blue, // background
                textColor: Colors.white, // foreground
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameWidget(),
                    ),
                  );
                },
                child: Text(
                  'Number Game',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}