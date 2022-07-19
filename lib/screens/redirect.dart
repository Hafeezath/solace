import 'package:flutter/material.dart';
import 'email.dart';
import 'email0.dart';
import 'email1.dart';

class Redirect extends StatefulWidget {
  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Text('Select from a list of professionals to request a consultation.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Email(),
                        ),
                      );
                    },
                    child: Text('Hiba Moideen'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Email0(),
                        ),
                      );
                    },
                    child: Text('Hafeezath Thajudheen'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Email1(),
                        ),
                      );
                    },
                    child: Text('Rihana Kamarudheen'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
