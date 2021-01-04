import 'package:education_app/ui/home/exam/exam_info_ui.dart';
import 'package:education_app/ui/home/profile_ui.dart';
import 'package:education_app/ui/home/video/Video.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/ui/home/CategoryPage.dart';

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
        child = CategoryPage(
          examType: 'NEET',
        );
        break;
      case 1:
        child = CategoryPage(
          examType: 'FMGE',
        );
        break;
      // case 2:
      //   child = ExamInfoScreen();
      //   break;
      case 2:
        child = ProfileScreen();
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        backgroundColor: Colors.grey[50],
        elevation: 6.0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/neet.png',
              scale: 6,
            ),
            title: Text(
              'NEET',
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
              'assets/images/fmge.png',
              scale: 6,
            ),
            
            title: Text('FMGE',
                style: TextStyle(
                    letterSpacing: 0.5,
                    fontFamily: 'Varela_Round',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54)),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.school),
          //   title: Text('TEST',
          //       style: TextStyle(
          //           letterSpacing: 0.5,
          //           fontFamily: 'Varela_Round',
          //           fontSize: 15,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.black54)),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: kPrimaryColor,),
            title: Text('PROFIE', style: TextStyle(
                    letterSpacing: 0.5,
                    fontFamily: 'Varela_Round',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
