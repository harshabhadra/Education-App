import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:education_app/Bloc/profile_bloc.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Model/subs_details.dart';
import 'package:education_app/ui/home/profile_ui.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/ui/home/CategoryPage.dart';

class Home extends StatefulWidget {
  final LoginResponse loginResponse;
  final ProfileResponse profileResponse;
  final SubsDetails subsDetails;

  const Home(
      {Key key, this.loginResponse, this.profileResponse, this.subsDetails})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  ProfileBloc _bloc = ProfileBloc();
  ProfileResponse _profileResponse;

  @override
  void initState() {
    _profileResponse = widget.profileResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (_index) {
      case 0:
        child = CategoryPage(
          examType: 'NEET',
          profileResponse: _profileResponse,
          subsDetails: widget.subsDetails,
        );
        break;
      case 1:
        child = CategoryPage(
          examType: 'FMGE',
          profileResponse: _profileResponse,
          subsDetails: widget.subsDetails,
        );
        break;
      case 2:
        child = ProfileScreen();
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (newIndex) => setState(() => _index = newIndex),
        selectedIndex: _index,
        backgroundColor: Colors.grey[50],
        showElevation: true,
        items: [
          BottomNavyBarItem(
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
              activeColor: kPrimaryColor),
          BottomNavyBarItem(
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
              activeColor: kPrimaryColor),
          BottomNavyBarItem(
              icon: Icon(
                Icons.account_circle,
                color: kPrimaryColor,
              ),
              title: Text('PROFIE',
                  style: TextStyle(
                      letterSpacing: 0.5,
                      fontFamily: 'Varela_Round',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54)),
              activeColor: kPrimaryColor),
        ],
      ),
    );
  }

  Widget _buildPage(ProfileBloc _bloc, Widget child) {
    return StreamBuilder(
        stream: _bloc.profileStrem,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              _profileResponse = snapshot.data;
              return SizedBox.expand(child: child);
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error.toString()}'));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
