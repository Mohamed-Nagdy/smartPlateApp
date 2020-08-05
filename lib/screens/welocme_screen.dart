import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_plate/screens/login_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: new Login(),
            title: new Text('Smart Plate', style: TextStyle(
             fontSize: 32,
             color: CupertinoColors.activeGreen
            ),
            ),
            image: new Image.asset('images/logo.png'),
            backgroundColor: Colors.white,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            loaderColor: CupertinoColors.activeGreen
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
