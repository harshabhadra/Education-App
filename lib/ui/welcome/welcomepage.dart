import 'package:carousel_pro/carousel_pro.dart';
import 'package:education_app/ui/authentication/Login.dart';
import 'package:education_app/ui/authentication/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("assets/images/background1.jpg"),
          AssetImage("assets/images/background.jpg"),
          AssetImage("assets/images/background4.jpg"),
        ],
        autoplay: true,
        dotSize: 6.0,
        indicatorBgPadding: 5.0,
        animationCurve: Curves.fastOutSlowIn,
      ),
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //SizedBox(height: 10,),
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: Text('Welcome',
                            textScaleFactor: 1.9,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 1.2,
                                fontSize: 15,
                                fontFamily: 'Varela_Round',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54)),
                      ),
                    ),

                    //SizedBox(height: 10,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width,
                      child: image_carousel,
                      //padding: ,
                    ),

                    // Welcome_Button_Login_Signup(context,size),
                    FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.25),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                height: 60,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.85,
                                elevation: 10,
                                color: HexColor('#8000d7'),
                                textColor: Colors.white,
                                child: Text(
                                  'ALREADY MEMBER? LOGIN',
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Varela_Round",
                                      fontSize: 12.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  loginUi(context, size);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FlatButton(
                                color: Colors.transparent,
                                textColor: Colors.black,
                                child: Text(
                                  'NEW HERE? SIGN UP',
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                      color: HexColor('#8000d7'),
                                      fontFamily: "Varela_Round",
                                      fontSize: 12.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {
                                  SignUpUi(context, size);
                                },
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
