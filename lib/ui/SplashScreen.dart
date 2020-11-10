import 'package:education_app/ui/welcome/welcomepage.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      routeName: '/',
      navigateAfterSeconds: WelcomePage(),
      title: Text(
        'Study Doc.',
        textScaleFactor: 1.5,
        textAlign: TextAlign.center,
        style: TextStyle(letterSpacing: 1.2, fontSize: 15, color: Colors.white),
      ),
      image: Image.asset('assets/images/splash.jpg'),
      backgroundColor: kPrimaryColor,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
    );
  }
}
