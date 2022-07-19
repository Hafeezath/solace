import 'dart:async';

import 'package:solace/screens/screens.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<firebase.User?> listener;

  @override
  void initState() {
    super.initState();
    _handleAuthenticatedState();
  }

  Future<void> _handleAuthenticatedState() async {
    final auth = firebase.FirebaseAuth.instance;
    if (!mounted) {
      return;
    }
    listener = auth.authStateChanges().listen((user) async {
      if (user != null) {
        // get Stream user token
        final callable =
            FirebaseFunctions.instance.httpsCallable('getStreamUserToken');

        final results = await Future.wait([
          callable(),
          // delay to show loading indicator
          Future.delayed(const Duration(seconds: 5)),
        ]);

        // connect Stream user
        final client = StreamChatCore.of(context).client;
        await client.connectUser(
          User(id: user.uid),
          results[0]!.data,
        );

        // authenticated
        Navigator.of(context).pushReplacement(HomeScreen.route);
      } else {
        // delay to show loading indicator
        await Future.delayed(const Duration(seconds: 5));
        // not authenticated
        Navigator.of(context).pushReplacement(LandingPage.route);
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: const Image(
          image: AssetImage('assets/images/appreciate.png'),
          //width: 20,
        ),
        //CircularProgressIndicator(),

      ),
    );
  }
}
