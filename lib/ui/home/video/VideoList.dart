import 'package:education_app/Model/Video.dart';
import 'package:education_app/ui/home/video/video_play_ui.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';

class VideoListUi extends StatefulWidget {
  final String categoryName;
  final List<VideoList> videos;
  const VideoListUi({
    Key key,
    @required this.categoryName,
    @required this.videos,
  }) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoListUi> {


  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SafeArea(
          child: Container(
            color: kPrimaryColor,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
              child:
                  Container(color: Colors.white, child: _buildVideoListPage()),
            ),
          ),
        ));
  }

  Widget _buildVideoListPage() {
    List<VideoList> _fList = List();
    for (VideoList video in widget.videos) {
      if (video.catagory == widget.categoryName) {
        _fList.add(video);
      }
    }
    return Container(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Demo',
                  ),
                  Tab(
                    text: 'Premium',
                  ),
                ],
              ),
              Container(
                height:
                    MediaQuery.of(context).size.height, //height of TabBarView
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5))),
                child: TabBarView(children: [
                  _buildList(_fList, 'Demo'),
                  _buildList(_fList, 'Premium')
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<VideoList> list, String type) {
    List<VideoList> videoList = List();
    for (VideoList video in list) {
      if (video.purchaseType == type) {
        videoList.add(video);
      }
    }
    return videoList.length == 0
        ? Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Text('Nothing to show'),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: videoList == null ? 0 : videoList.length,
              separatorBuilder: (context, builder) =>
                  Divider(color: Colors.grey),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoPlayUi(
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
                              child:
                                  Image.asset("assets/images/background.jpg"),
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
}
