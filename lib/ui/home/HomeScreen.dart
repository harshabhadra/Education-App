import 'package:education_app/ui/home/exam/exam_info_ui.dart';
import 'package:education_app/ui/home/video/Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/ui/home/CategoryPage.dart';
import 'package:education_app/ui/home/HomePage.dart';
import 'package:education_app/ui/home/profile.dart';
class Home extends StatefulWidget {
  final LoginResponse loginResponse;
  
  const Home({
    Key key,
    this.loginResponse,
  }) : super(key: key);
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  
  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_index) {
      case 0:
        child = CategoryPage();
        break;
      case 1:
        child = VideoPage();
        break;
      case 2:
        child = ExamInfoScreen();
        break;
      case 3:
        child = ProfilePage();
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
              scale: 20,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  letterSpacing: 0.5,
                  fontFamily: 'Varela_Round',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/video1.png',
              scale: 25,
            ),
            title: Text('Video',
                style: TextStyle(
                    letterSpacing: 0.5,
                    fontFamily: 'Varela_Round',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('TEST',
                style: TextStyle(
                    letterSpacing: 0.5,
                    fontFamily: 'Varela_Round',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('PROFIE'),
          ),
        ],
      ),
    );
  }
}
