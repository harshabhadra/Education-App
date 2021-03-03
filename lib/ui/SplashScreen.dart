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
  DatabaseLogin databaseLogin;
  LoginResponse loginResponse;
  @override
  void initState() {
    var box = Hive.box('user');
    if (box.length > 0) {
      print('box is not empty, box length: ${box.length}');
      databaseLogin = box.getAt(0);
      LoginBloc bloc = LoginBloc();
      bloc.login(databaseLogin.email, databaseLogin.password);
      bloc.loginStream.listen((event) {
        LoginResponse response = event;
        bloc.getProfile();
        bloc.profileStream.listen((event) {
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return Home(
                    loginResponse: response,
                    profileResponse: event,
                  );
                }), (route) => false);
              });
            });
          });
        });
      });
    } else {
      print('box is empty, box length: ${box.length}');
      databaseLogin = null;
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return WelcomePage(
                email: "",
                password: "",
              );
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/icon/app_icon.png'),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
