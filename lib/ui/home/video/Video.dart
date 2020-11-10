import 'package:education_app/Bloc/VideoCategoryBloc.dart';
import 'package:education_app/Bloc/VideoListBloc.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Model/Video.dart';
import 'package:education_app/ui/home/video/VideoList.dart';
import 'package:education_app/ui/home/video/VideoPlay.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
        backgroundColor: Colors.white,
        body: BlocProvider(
          bloc: bloc,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Image.asset('assets/images/3748552.jpg'),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 30),
                  child: Text(
                    "Video Categories",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Varela_Round',
                        fontSize: 25.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .40),
                  height: MediaQuery.of(context).size.height * .60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        // child:
                        child: Center(child: _buildResults(catBloc))),
                  ),
                ),
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
              : GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  children: List.generate(catList == null ? 0 : catList.length,
                      (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VideoListUi(categoryName: catList[index])));
                      },
                      child: Card(
                        color: Colors.indigo[50],
                        margin: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16.0),
                                topLeft: Radius.circular(16.0))),
                        child: Stack(
                          children: [
                            Container(
                                margin: EdgeInsets.all(8.0),
                                child: Image.asset("assets/images/video1.png")),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 32.0,
                                color: Colors.indigo[50],
                                child: Text(catList[index]),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
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
