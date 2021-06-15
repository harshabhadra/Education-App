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
  ProfileResponse _profileResponse;

  @override
  void initState() {
    _profileResponse = widget.profileResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 30,
              ),
              TabBar(labelColor: Colors.black, tabs: [
                Tab(
                  text: "NEET",
                ),
                Tab(
                  text: "FMGE",
                ),
                Tab(
                  text: "PROFILE",
                )
              ]),
              Container(
                  height:
                      MediaQuery.of(context).size.height, //height of TabBarView
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  child: TabBarView(children: [
                    CategoryPage(
                      examType: 'NEET',
                      profileResponse: _profileResponse,
                      subsDetails: widget.subsDetails,
                    ),
                    CategoryPage(
                      examType: 'FMGE',
                      profileResponse: _profileResponse,
                      subsDetails: widget.subsDetails,
                    ),
                    ProfileScreen()
                  ]))
            ],
          ),
        ),
      )),
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
