import 'package:dio/dio.dart';
import 'package:education_app/Bloc/viedeos_bloc.dart';
import 'package:education_app/Model/Video.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:random_color/random_color.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/ui/home/video/VideoList.dart';

class VideoPage extends StatefulWidget {
  final String examType;
  const VideoPage({
    Key key,
    @required this.examType,
  }) : super(key: key);
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // List<VideoList> videoList;
  var isLoading = false;
  final bloc = VideosBloc();
  Dio dio = Dio();
  List<VideoList> _videos = List<VideoList>();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    bloc.refreshAndgetVideos(widget.examType);
    bloc.videoStream.listen((event) {
      if (event is List<VideoList>) {
        _videos.addAll(event);
        print('no. of videos in ui : ${_videos.length}');
      } else {
        ErrorModel errorModel = event;
        print(errorModel.description);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Videos'),
          backgroundColor: Colors.purple[200],
          elevation: 0,
        ),
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: BlocProvider(
            bloc: bloc,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 200,
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
                  _buildVideoPage(context, bloc)
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildVideoPage(BuildContext context, VideosBloc bloc) {
    return StreamBuilder(
      stream: bloc.videoCategoriesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            List<String> catList = snapshot.data;
            return catList == null
                ? Center(
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _buildCategoryList(context, catList);
          }
        } else {
          return Container(
            margin: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCategoryList(BuildContext context, List<String> catList) {
    RandomColor _randomColor = RandomColor();
    return AnimationLimiter(
      child: GridView.count(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        children: List.generate(catList == null ? 0 : catList.length, (index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 1000),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoListUi(
                                    categoryName: catList[index],
                                    videos: _videos,
                                  )));
                    },
                    child: Card(
                      color: _randomColor.randomColor(
                          colorBrightness: ColorBrightness.primary,
                          colorSaturation: ColorSaturation.lowSaturation,
                          colorHue: ColorHue.multiple(
                              colorHues: [ColorHue.blue, ColorHue.purple])),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ZStack(
                          [
                            Container(
                              alignment: Alignment.center,
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
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
