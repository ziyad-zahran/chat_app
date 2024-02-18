import 'dart:async';

import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splash();
  }
   _splash() async
  {
    var duration = const Duration(seconds: 3);
    return Timer(duration, _navigateToHome);
  }
  void _navigateToHome()
  {
    Navigator.pushNamed(context, LoginScreen.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                  'assets/images/logo.png',

              ),
              const CircularProgressIndicator(),
            ],
          )

      ),
    );
  }
}
