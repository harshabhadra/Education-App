import 'package:education_app/ui/home/video/VideoPlay.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:education_app/Bloc/VideoCacheBloc.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/database/DatabaseVideo.dart';
import 'package:velocity_x/velocity_x.dart';

class VideoListUi extends StatefulWidget {
  final String categoryName;
  const VideoListUi({
    Key key,
    @required this.categoryName,
  }) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoListUi> {
  final vBloc = VideoCacheBloc();

  @override
  void initState() {
    vBloc.getCacheVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoCacheBloc>(
      bloc: vBloc,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            elevation: 0,
            title: Text(
              widget.categoryName,
              style: TextStyle(
                fontFamily: 'Varela_Round',
                fontSize: 20.0,
              ),
            ),
          ),
          body: ZStack([
            Container(
              height: 64,
              margin: EdgeInsets.only(bottom: 32),
            color: kPrimaryColor,
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
              child: Container(
                  color: Colors.white,
                  child: _buildVideos(vBloc, widget.categoryName)),
            ),
          ])),
    );
  }
}

Widget _buildVideos(VideoCacheBloc bloc, String catName) {
  return StreamBuilder(
    stream: bloc.videoListStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        } else {
          List<DatabaseVideoList> list = snapshot.data;
          return _buildList(list, catName);
        }
      } else {
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      }
    },
  );
}

Widget _buildList(List<DatabaseVideoList> list, String catName) {
  var videoList = <DatabaseVideoList>{};

  for (var video in list) {
    if (video.catagory == catName) {
      videoList.add(video);
    }
  }
  return videoList == null
      ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        )
      : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: videoList == null ? 0 : videoList.length,
            separatorBuilder: (context, builder) => Divider(color: Colors.grey),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoApp(
                                video: videoList.toList()[index],
                              )));
                },
                child: Card(
                  color: Colors.indigo[50],
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.indigo[50],
                        child: SizedBox(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset("assets/images/background.jpg"),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            videoList.toList()[index].title,
                            style: TextStyle(
                              fontFamily: 'Varela_Round',
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
      );
}
