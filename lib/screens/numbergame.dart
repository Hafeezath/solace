import 'dart:async';
import 'dart:math';

import 'package:solace/screens/screens.dart';
import 'package:flutter/material.dart';
import 'gamescreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkBlue = Color.fromARGB(255, 18, 32, 47);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: GameWidget(),
    );
  }
}

const _targetColors = [
  Colors.orange,
  Colors.green,
  Colors.yellow,
  Colors.blue
];
const _textColors = [
  Colors.blue,
  Colors.yellow,
  Colors.green,
  Colors.orange
];
const _colorNames = [
  'orange',
  'green',
  'yellow',
  'blue'
];

enum TargetType { color, number }

class TargetData {
  TargetData({required this.type, required this.index});
  final TargetType type;
  final int index;

  String get text => type == TargetType.color ? 'COLOR ${_colorNames[index]}' : 'NUMBER $index';
  Color get color => _textColors[index];
}

class GameTimer {
  Timer? _timer;
  ValueNotifier<int> remainingSeconds = ValueNotifier<int>(10);

  void startGame() {
    _timer?.cancel();
    remainingSeconds.value = 15;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      remainingSeconds.value--;
      if (remainingSeconds.value == 0) {
        _timer?.cancel();
      }
    });
  }
}

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key}) : super(key: key);
  static const String id = 'gamewidget';
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  static final _rng = Random();

  late Alignment _playerAlignment;
  late List<Alignment> _targets;
  late TargetData _targetData;
  int _score = 0;
  bool _gameInProgress = false;
  GameTimer _gameTimer = GameTimer();

  @override
  void initState() {
    super.initState();
    _playerAlignment = Alignment(0, 0);
    _gameTimer.remainingSeconds.addListener(() {
      if (_gameTimer.remainingSeconds.value == 0) {
        setState(() {
          _gameInProgress = false;
        });
      }
    });
    _randomize();
  }

  void _randomize() {
    _targetData = TargetData(
      type: TargetType.values[_rng.nextInt(2)],
      index: _rng.nextInt(_targetColors.length),
    );
    _targets = [
      for (var i = 0; i < _targetColors.length; i++)
        Alignment(
          _rng.nextDouble() * 2 - 1,
          _rng.nextDouble() * 2 - 1,
        )
    ];
  }

  void _startGame() {
    _randomize();
    setState(() {
      _score = 0;
      _gameInProgress = true;
    });
    _gameTimer.startGame();
  }

  // This method contains most of the game logic
  void _handleTapDown(TapDownDetails details, int? selectedIndex) {
    if (!_gameInProgress) {
      return;
    }
    final size = MediaQuery.of(context).size;
    setState(() {
      if (selectedIndex != null) {
        _playerAlignment = _targets[selectedIndex];
        final didScore = selectedIndex == _targetData.index;
        Future.delayed(Duration(milliseconds: 250), () {
          setState(() {
            if (didScore) {
              _score++;
            } else {
              _score--;
            }
            _randomize();
          });
        });
        // score point
      } else {
        _playerAlignment = Alignment(
          2 * (details.localPosition.dx / size.width) - 1,
          2 * (details.localPosition.dy / size.height) - 1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Handle taps anywhere
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) => _handleTapDown(details, null),
            ),
          ),
          // Player
          // TO DO: Convert to AnimatedAlign & add a duration argument
          AnimatedAlign(
            alignment: _playerAlignment,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: _targetData.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Targets
          for (var i = 0; i < _targetColors.length; i++)
            GestureDetector(
              // Handle taps on targets
              onTapDown: (details) => _handleTapDown(details, i),
              // TO DO: Convert to AnimatedAlign & add a duration argument
              child: AnimatedAlign(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: _targets[i],
                child: Target(
                  color: _targetColors[i],
                  textColor: _textColors[i],
                  text: i.toString(),
                ),
              ),
            ),
          // Next Command
          Align(
            alignment: Alignment(0, 0),
            child: IgnorePointer(
              ignoring: _gameInProgress,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextPrompt(
                    'Score: $_score',
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  TextPrompt(
                    _gameInProgress ? 'Tap ${_targetData.text}' : 'Game Over!',
                    color: _gameInProgress ? _targetData.color : Colors.white,
                  ),
                  _gameInProgress
                      ? ValueListenableBuilder(
                    valueListenable: _gameTimer.remainingSeconds,
                    builder: (context, remainingSeconds, _) {
                      return TextPrompt(remainingSeconds.toString(), color: Colors.white);
                    },
                  )
                      : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(width: 2, color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextPrompt('Start', color: Colors.white),
                    ),
                    onPressed: _startGame,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Target extends StatelessWidget {
  const Target({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
  }) : super(key: key);
  final Color color;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class TextPrompt extends StatelessWidget {
  const TextPrompt(
      this.text, {
        Key? key,
        required this.color,
        this.fontSize = 32,
      }) : super(key: key);
  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      child: Text(text),
      duration: Duration(milliseconds: 250),
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        shadows: [
          Shadow(
            blurRadius: 4.0,
            color: Colors.black,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
    );
  }
}