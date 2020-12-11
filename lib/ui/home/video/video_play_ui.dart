import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:vimeoplayer/vimeoplayer.dart';

import 'package:education_app/database/DatabaseVideo.dart';

class VideoPlayUi extends StatefulWidget {
  final DatabaseVideoList video;
  const VideoPlayUi({
    Key key,
    this.video,
  }) : super(key: key);

  @override
  _VideoPlayUiState createState() => _VideoPlayUiState();
}

class _VideoPlayUiState extends State<VideoPlayUi> {
  String id;

  @override
  void initState() {
    String videoUrl = widget.video.url;
    var sArray = videoUrl.split('https://vimeo.com/');
    id = sArray[1];
    print(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).orientation == Orientation.portrait
            ? AppBar(
                leading: BackButton(color: Colors.white),
                title: Text(widget.video.catagory),
                backgroundColor: kPrimaryColor,
              )
            : PreferredSize(
                child: Container(
                  color: Colors.transparent,
                ),
                preferredSize: Size(0.0, 0.0),
              ),
        body: Column(
          children: [
            VimeoPlayer(
              id: id,
              autoPlay: true,
            ),
            Text(widget.video.title, style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Varela_Round',
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700),)
          ],
        ));
  }
}
