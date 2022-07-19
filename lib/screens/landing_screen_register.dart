import 'package:flutter/material.dart';

import 'package:solace/screens/screens.dart';



class LandingReg extends StatefulWidget {
  const LandingReg({Key? key}) : super(key: key);
  static const String id = 'LandingReg';

  @override
  State<LandingReg> createState() => _LandingRegState();
}

class _LandingRegState extends State<LandingReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Are you a professional? Or seeking support? \n Register Now',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              color: Colors.blue, // background
              textColor: Colors.white, // foreground
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );

              },
              child: Text(
                'Support Seeker',
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              color: Colors.blue, // background
              textColor: Colors.white, // foreground
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreenProf(),
                  ),
                );

              },
              child: Text(
                'Professional',
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              color: Colors.blue, // background
              textColor: Colors.white, // foreground
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LandingPage(),
                  ),
                );

              },
              child: Icon(
                Icons.arrow_back,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}