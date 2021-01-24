import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/profile_bloc.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/ui/welcome/welcomepage.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_color/random_color.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc bloc = ProfileBloc();

  @override
  void initState() {
    bloc.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                bloc.logOutUser();
                setState(() {
                  bloc.logoutStream.listen((event) {
                    if (event) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return WelcomePage(email: "",password: "",);
                        }), (route) => false);
                      });
                    }
                  });
                });
              },
            ),
          )
        ],
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocProvider(
          bloc: bloc,
          child: SingleChildScrollView(
            child: _buildProfile(bloc),
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(ProfileBloc bloc) {
    return StreamBuilder(
      stream: bloc.profileStrem,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            ProfileResponse profileResponse = snapshot.data;
            return AnimationLimiter(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 100.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32),
                                  bottomRight: Radius.circular(32),
                                ),
                                child: Container(
                                    color: kPrimaryColor,
                                    child: _buildInfo(profileResponse)))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                          child: Center(
                            child: Text(
                              'Course: ',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        _buildAddress(profileResponse)
                      ]),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _buildInfo(ProfileResponse profileResponse) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
              radius: 45,
              backgroundColor: kPrimaryColor,
              child: profileResponse.studentInfo.gender == 'M'
                  ? SvgPicture.asset('assets/images/male_avatar.svg')
                  : SvgPicture.asset('assets/images/female_avatar.svg')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(profileResponse.studentInfo.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                  child: Text(
                    profileResponse.studentInfo.email,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                  child: Text(
                      profileResponse.studentInfo.contactNumber.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddress(ProfileResponse profileResponse) {
    RandomColor _randomColor = RandomColor();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              Text(
                'Address',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.edit_outlined),
                onPressed: () {},
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Text(
            'Address: ' + profileResponse.studentInfo.address,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(
            'Country: ' + profileResponse.studentInfo.country,
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }
}
