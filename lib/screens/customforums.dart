import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



  class CustomForums extends StatelessWidget {
  static const String id = 'customforums';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Expanded(
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Cultivating a sense of community.\n Choose forums relevant to your interest',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        FlatButton(
                          child: Text("The Eating Disorders Forum"),
                          onPressed: () async {
                            String url = "https://www.mentalhealthforum.net/forum/forums/eating-disorders-forum.32/";
                            var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                            if (urllaunchable) {
                              await launch(url); //launch is from url_launcher package to launch URL
                            } else {
                              print("URL can't be launched.");
                            }
                          },
                        ),
                        SizedBox(height: 8.0),
                        FlatButton(
                          child: Text("BeyondBlue Online Forum "),
                          onPressed: () async {
                            String url = "https://www.beyondblue.org.au/get-support/online-forums";
                            var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                            if (urllaunchable) {
                              await launch(url); //launch is from url_launcher package to launch URL
                            } else {
                              print("URL can't be launched.");
                            }
                          },
                        ),
                        SizedBox(height: 8.0),
                        FlatButton(
                          child: Text("Self Healing | Mental Health Forum"),
                          onPressed: () async {
                            String url = "https://www.mentalhealthforum.net/forum/threads/self-healing.345792/";
                            var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                            if (urllaunchable) {
                              await launch(url); //launch is from url_launcher package to launch URL
                            } else {
                              print("URL can't be launched.");
                            }
                          },
                        ),
                        SizedBox(height: 8.0),
                        FlatButton(
                          child: Text("ReachOut Forums | Accessible 24/7"),
                          onPressed: () async {
                            String url = "http://forums.au.reachout.com/";
                            var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                            if (urllaunchable) {
                              await launch(url); //launch is from url_launcher package to launch URL
                            } else {
                              print("URL can't be launched.");
                            }
                          },
                        ),
                        SizedBox(height: 25.0),
                        Container(
                          child: Image(
                            image: AssetImage(
                              'assets/images/appreciate.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}