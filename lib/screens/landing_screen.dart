import 'package:flutter/material.dart';
import 'package:solace/screens/screens.dart';


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
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  static Route get route => MaterialPageRoute(
    builder: (context) => LandingPage(),
  );
  const LandingPage({Key? key}) : super(key: key);
  static const String id = 'landpage';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Are you a professional? Or seeking support? \n Login Now',
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
                        builder: (context) => const SignInScreen(),
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
                        builder: (context) => const SignInScreenProf(),
                      ),
                  );


                },
                child: Text(
                  'Professional',
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not registered yet?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LandingReg(),
                        ),
                      );
                    },
                    child: const Text('Create an account'),
                  ),
                ],
              ),
              Container(
                child: Image(
                  image: AssetImage('assets/images/relax.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}