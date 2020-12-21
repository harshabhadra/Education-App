
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 8, right: 120),
              child: Text(
                'Book',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 0.5,
                    fontFamily: 'Varela_Round',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          ),

          FutureBuilder<List<dynamic>>(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
            
                return new ListView.builder(
                    //scrollDirection:Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(1.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new GestureDetector(
                            onTap: () {
                              // Navigator.push(

                              //     context, MaterialPageRoute(

                              //     builder: (context)=>Viewpdf1(demoBookLink(snapshot.data[0]))));
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 9, top: 5, right: 100),
                              width: 65,
                              height: 70,
                              //color: Colors.black45,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://image.freepik.com/free-vector/distance-course-isometric_98292-7151.jpg',
                                    ),
                                    fit: BoxFit.cover),
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
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
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          FittedBox(
            fit: BoxFit.fitWidth,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 8, right: 120),
              child: Text(
                'Video',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 0.5,
                    fontFamily: 'Varela_Round',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          ),

          FittedBox(
            fit: BoxFit.fitWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => VideoPage1()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 9, top: 10, right: 100),
                    width: 65,
                    height: 70,
                    //color: Colors.black45,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://image.freepik.com/free-vector/video-player-banner_1366-360.jpg',
                          ),
                          fit: BoxFit.cover),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
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
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 8, right: 120),
              child: Text(
                'Online Test',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 0.5,
                    fontFamily: 'Varela_Round',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 9, top: 10, right: 100),
                    width: 65,
                    height: 70,
                    //color: Colors.black45,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://image.freepik.com/free-vector/online-certification-illustration-concept_23-2148573547.jpg',
                          ),
                          fit: BoxFit.cover),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}
