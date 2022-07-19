import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solace/screens/screens.dart';
import 'gamescreen.dart';
//void main() {
//runApp(const MyApp());
//}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const TicTacToe(),
      //title: 'Flutter Demo Home Page'
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);
  static const String id = 'tictactoe';
//, required this.title
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> with AutomaticKeepAliveClientMixin {
  var tiles = List.filled(9, 0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      //title: Text(widget.title),
      //),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'A Game of Tic-Tac-Toe',
                style: GoogleFonts.vt323(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    for (var i = 0; i < 9; i++)
                      Container(
                        color: Colors.teal[200],
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              tiles[i] = 1;
                              runAi();
                            });
                          },
                          child: Center(
                              child: Text(
                                tiles[i] == 0
                                    ? ''
                                    : tiles[i] == 1
                                    ? 'X'
                                    : 'O',
                                style: GoogleFonts.pacifico(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    isWinning(1, tiles)
                        ? 'CONGRATS! YOU WON!'
                        : isWinning(2, tiles)
                        ? 'You lost!'
                        : 'Your move',
                    style: GoogleFonts.vt323(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        tiles = List.filled(9, 0);
                      });
                    },
                    child: Text(
                      'Restart',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.teal[500],
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.teal[500],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void runAi() async {
    await Future.delayed(Duration(milliseconds: 200));

    int? winning;
    int? blocking;
    int? normal;

    for (var i = 0; i < 9; i++) {
      var val = tiles[i];

      if (val > 0) {
        continue;
      }

      var future = [
        ...tiles
      ]..[i] = 2;

      if (isWinning(2, future)) {
        winning = i;
      }

      future[i] = 1;

      if (isWinning(1, future)) {
        blocking = i;
      }

      normal = i;
    }

    var move = winning ?? blocking ?? normal;

    if (move != null) {
      setState(() {
        tiles[move] = 2;
      });
    }
  }

  bool isWinning(int who, List<int> tiles) {
    return (tiles[0] == who && tiles[1] == who && tiles[2] == who) || (tiles[3] == who && tiles[4] == who && tiles[5] == who) || (tiles[6] == who && tiles[7] == who && tiles[8] == who) || (tiles[0] == who && tiles[4] == who && tiles[8] == who) || (tiles[2] == who && tiles[4] == who && tiles[6] == who) || (tiles[0] == who && tiles[3] == who && tiles[6] == who) || (tiles[1] == who && tiles[4] == who && tiles[7] == who) || (tiles[2] == who && tiles[5] == who && tiles[8] == who);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}