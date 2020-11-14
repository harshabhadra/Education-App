import 'package:education_app/Bloc/VideoCategoryBloc.dart';
import 'package:education_app/Bloc/VideoListBloc.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/ui/home/video/VideoList.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:velocity_x/velocity_x.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // List<VideoList> videoList;
  var isLoading = false;
  final bloc = VideoListBloc();
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    // this.getAllVideos();
    isLoading = true;
    bloc.getVideos(dio);
  }

  @override
  Widget build(BuildContext context) {
    final catBloc = VideoCategoryBloc();
    catBloc.getCategories();
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: BlocProvider(
          bloc: bloc,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(
                            "assets/images/3748552.jpg",
                          ),
                        )),
                      )),
                ),
                _buildResults(catBloc)
              ],
            ),
          ),
        ));
  }
}

Widget _buildResults(VideoCategoryBloc bloc) {
  return StreamBuilder(
    stream: bloc.categoryListStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        } else {
          List<String> catList = snapshot.data;
          return catList == null
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 16.0),
                      child: Text(
                        'All Categories',
                        style: TextStyle(
                            fontFamily: 'Varela_Round',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GridView.count(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        children: List.generate(
                            catList == null ? 0 : catList.length, (index) {
                          return Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoListUi(
                                            categoryName: catList[index])));
                              },
                              child: Card(
                                color: Colors.black.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ZStack(
                                    [
                                      Container(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                              "assets/images/21095.jpg")),
                                      Container(
                                        alignment: Alignment.center,
                                        color: Colors.black.withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            catList[index].length < 18
                                                ? catList[index]
                                                : "${catList[index]}",
                                            style: TextStyle(
                                              fontFamily: 'Varela_Round',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
        }
      } else {
        return Container(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
