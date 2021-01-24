import 'package:education_app/Bloc/LoginBloc.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/database/DatabaseLogin.dart';
import 'package:education_app/ui/home/HomeScreen.dart';
import 'package:education_app/ui/welcome/welcomepage.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var box = Hive.box('user');
  DatabaseLogin databaseLogin;
  LoginResponse loginResponse;
  @override
  void initState() {
    if (box.isNotEmpty) {
      databaseLogin = box.getAt(0);
      LoginBloc bloc = LoginBloc();
      bloc.login(databaseLogin.email, databaseLogin.password);
      bloc.loginStream.listen((event) {
        LoginResponse response = event;
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return Home(loginResponse: response);
              }), (route) => false);
            });
          });
        });
      });
    } else {
      databaseLogin = null;
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return WelcomePage(email: "",password: "",);
            }), (route) => false);
          });
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 64, 32, 64),
              child: Image.asset('assets/images/splash.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Study Doc',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 64),
              child: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
