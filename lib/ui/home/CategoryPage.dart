import 'package:education_app/Bloc/profile_bloc.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Model/subs_details.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:education_app/ui/home/Ebook/Ebook.dart';
import 'package:education_app/ui/home/exam/exam_info_ui.dart';
import 'package:education_app/ui/home/video/Video.dart';
import 'package:lottie/lottie.dart';

class CategoryPage extends StatefulWidget {
  final String examType;
  final ProfileResponse profileResponse;
  final SubsDetails subsDetails;
  const CategoryPage(
      {Key key,
      @required this.examType,
      @required this.profileResponse,
      this.subsDetails})
      : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    print('profile info: ${widget.profileResponse.studentInfo.name}');
    SubsDetails _subDetails = widget.subsDetails;
    if (_subDetails != null) {
      String status = _subDetails.status;
      if (status != 'active') {
        if (status == 'pending' || status == 'halted') {
          _buildWarningDialog('Subscription $status',
              'Your Subcription is $status. Update your subcriptions info or Cancel Subscription');
        } else {
          _buildSubStatusDialog('Subscription $status');
        }
      }
    }
    super.initState();
  }

  void _buildSubStatusDialog(String title) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(title),
            actions: [
              RaisedButton(
                onPressed: () {},
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Restart Subcription',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  void _buildWarningDialog(String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(title),
            content: Text(message),
            actions: [
              RaisedButton(
                onPressed: () {},
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Update Subcription',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Cancel Subcription',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //bottomSheet: Image.asset('assets/images/background3.jpg',fit: BoxFit.fill,),
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/background3.jpg'),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 30),
            child: Text(
              "Welcome to ${widget.examType}",
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Varela_Round',
                  fontSize: 25.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .45),
              height: MediaQuery.of(context).size.height * .55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Stack(
                //scrollDirection: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 30),
                    child: Text(
                      "Course For You",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Varela_Round',
                          fontSize: 17.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => VideoPage(
                                //             examType: widget.examType,
                                //             profileResponse:
                                //                 widget.profileResponse)));
                                Dialog _commingDialog = Dialog(
                                  child: Container(
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          child: Image.asset(
                                            'assets/images/coming.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return _commingDialog;
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 5,
                                    top: 15,
                                    bottom: MediaQuery.of(context).size.height *
                                        .025),
                                width: 30,
                                height: 40,
                                //color: Colors.black45,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3, left: 5),
                                  child: Text(
                                    'Video',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Varela_Round',
                                        fontSize: 4.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.freepik.com/free-vector/video-player-banner_1366-360.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(1, 2),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Ebook(
                                              examType: widget.examType,
                                              profileResponse:
                                                  widget.profileResponse,
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 5,
                                    top: 15,
                                    bottom: MediaQuery.of(context).size.height *
                                        .025),
                                width: 30,
                                height: 40,
                                //color: Colors.black45,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 30, left: 5),
                                  child: Text(
                                    'e-Book',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Varela_Round',
                                        fontSize: 4.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.freepik.com/free-vector/distance-course-isometric_98292-7151.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(1, 2),
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ExamInfoScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 5,
                                    top: 15,
                                    bottom: MediaQuery.of(context).size.height *
                                        .025),
                                width: 30,
                                height: 40,
                                //color: Colors.black45,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3, left: 5),
                                  child: Text(
                                    'Test',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Varela_Round',
                                        fontSize: 4.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.freepik.com/free-vector/survey-form-with-pencil-vector-illustration-hand-holding-fill-check-list-paper-sheet-clipboard_185038-14.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(1, 2),
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
